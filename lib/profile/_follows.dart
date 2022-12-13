import 'package:fritter/catcher/errors.dart';
import 'package:flutter/material.dart';
import 'package:fritter/catcher/errors.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:fritter/generated/l10n.dart';

class ProfileFollows extends StatefulWidget {
  final UserWithExtra user;
  final String type;

  const ProfileFollows({Key? key, required this.user, required this.type}) : super(key: key);

  @override
  State<ProfileFollows> createState() => _ProfileFollowsState();
}

class _ProfileFollowsState extends State<ProfileFollows> with AutomaticKeepAliveClientMixin<ProfileFollows> {
  late PagingController<int?, UserWithExtra> _pagingController;

  final int _pageSize = 200;

  @override
  bool get wantKeepAlive => true;

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

      if (!mounted) {
        return;
      }

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
    super.build(context);

    return PagedListView<int?, UserWithExtra>(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      addAutomaticKeepAlives: false,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, user, index) => UserTile(user: UserSubscription.fromUser(user)),
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
