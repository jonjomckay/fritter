import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet/conversation.dart';
import 'package:fritter/ui/errors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StatusScreenArguments {
  final String id;
  final String? username;

  StatusScreenArguments({required this.id, required this.username});

  @override
  String toString() {
    return 'StatusScreenArguments{id: $id, username: $username}';
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as StatusScreenArguments;

    return _StatusScreen(username: args.username, id: args.id);
  }
}

class _StatusScreen extends StatefulWidget {
  final String? username;
  final String id;

  const _StatusScreen({Key? key, required this.username, required this.id}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<_StatusScreen> {
  final _pagingController = PagingController<String?, TweetChain>(firstPageKey: null);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((cursor) {
      _loadTweet(cursor);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future _loadTweet(String? cursor) async {
    try {
      var result = await Twitter.getTweet(widget.id, cursor: cursor);
      if (result.cursorBottom != null && result.cursorBottom == _pagingController.nextPageKey) {
        _pagingController.appendLastPage([]);
      } else {
        _pagingController.appendPage(result.chains, result.cursorBottom);
      }
    } catch (e, stackTrace) {
      _pagingController.error = [e, stackTrace];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PagedListView<String?, TweetChain>(
        padding: EdgeInsets.zero,
        pagingController: _pagingController,
        addAutomaticKeepAlives: false,
        shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, chain, index) {
            return TweetConversation(id: chain.id, tweets: chain.tweets, username: null, isPinned: chain.isPinned);
          },
          firstPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
            error: _pagingController.error[0],
            stackTrace: _pagingController.error[1],
            prefix: 'Unable to load the tweet',
            onRetry: () => _loadTweet(_pagingController.firstPageKey),
          ),
          newPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
            error: _pagingController.error[0],
            stackTrace: _pagingController.error[1],
            prefix: 'Unable to load the next page of replies',
            onRetry: () => _loadTweet(_pagingController.nextPageKey),
          ),
          noItemsFoundIndicatorBuilder: (context) {
            return Center(
              child: Text('Couldn\'t find any tweets by this user!'),
            );
          },
        ),
      ),
    );
  }
}