import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileFollows extends StatefulWidget {
  final User user;
  final String type;

  const ProfileFollows({Key? key, required this.user, required this.type}) : super(key: key);

  @override
  _ProfileFollowsState createState() => _ProfileFollowsState();
}

class _ProfileFollowsState extends State<ProfileFollows> {
  late PagingController<int?, User> _pagingController;

  int _pageSize = 200;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _loadFollows(cursor);
    });
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
      } else {
        _pagingController.appendPage(result.users, result.cursorBottom);
      }
    } catch (e, stackTrace) {
      _pagingController.error = [e, stackTrace];
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
          prefix: 'Unable to load the list of follows',
          onRetry: () => _loadFollows(_pagingController.firstPageKey),
        ),
        newPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
          error: _pagingController.error[0],
          stackTrace: _pagingController.error[1],
          prefix: 'Unable to load the next page of follows',
          onRetry: () => _loadFollows(_pagingController.nextPageKey),
        ),
        noItemsFoundIndicatorBuilder: (context) {
          var text = widget.type == 'following'
            ? 'This user does not follow anyone!'
            : 'This user does not have anyone following them!';

          return Center(
            child: Text(text),
          );
        },
      ),
    );
  }
}
