import 'package:catcher/catcher.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:fritter/generated/l10n.dart';

class ProfileFollows extends StatefulWidget {
  final User user;
  final String type;

  const ProfileFollows({Key? key, required this.user, required this.type}) : super(key: key);

  @override
  _ProfileFollowsState createState() => _ProfileFollowsState();
}

class _ProfileFollowsState extends State<ProfileFollows> {
  late PagingController<int?, User> _pagingController;

  final int _pageSize = 200;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _loadFollows(cursor);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future _loadFollows(int? cursor) async {
    try {
      var result = await Twitter.getProfileFollows(
        widget.user.screenName!,
        widget.type,
        cursor: cursor,
        count: _pageSize,
      );

      if (result.cursorBottom == _pagingController.nextPageKey) {
        _pagingController.appendLastPage([]);
      } else if (result.cursorBottom == 0) {
        _pagingController.appendLastPage(result.users);
      } else {
        _pagingController.appendPage(result.users, result.cursorBottom);
      }
    } catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);
      if (mounted) {
        _pagingController.error = [e, stackTrace];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int?, User>(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      addAutomaticKeepAlives: false,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, user, index) {
          return UserTile(
            id: user.idStr!,
            name: user.name!,
            screenName: user.screenName!,
            imageUri: user.profileImageUrlHttps,
            verified: user.verified!,
          );
        },
        firstPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
          error: _pagingController.error[0],
          stackTrace: _pagingController.error[1],
          prefix: L10n.of(context).unable_to_load_the_list_of_follows,
          onRetry: () => _loadFollows(_pagingController.firstPageKey),
        ),
        newPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
          error: _pagingController.error[0],
          stackTrace: _pagingController.error[1],
          prefix: L10n.of(context).unable_to_load_the_next_page_of_follows,
          onRetry: () => _loadFollows(_pagingController.nextPageKey),
        ),
        noItemsFoundIndicatorBuilder: (context) {
          var text = widget.type == 'following'
              ? L10n.of(context).this_user_does_not_follow_anyone
              : L10n.of(context).this_user_does_not_have_anyone_following_them;

          return Center(
            child: Text(text),
          );
        },
      ),
    );
  }
}
