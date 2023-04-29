import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/search/search_model.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class SearchArguments {
  final String? query;
  final bool focusInputOnOpen;

  SearchArguments({this.query, this.focusInputOnOpen = false});
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as SearchArguments;

    return _SearchScreen(query: arguments.query, focusInputOnOpen: arguments.focusInputOnOpen);
  }
}


class _SearchScreen extends StatefulWidget {
  final String? query;
  final bool focusInputOnOpen;

  const _SearchScreen({Key? key, this.query, this.focusInputOnOpen = false}) : super(key: key);

  @override
  State<_SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.focusInputOnOpen) {
      _focusNode.requestFocus();
    }

    _queryController.text = widget.query ?? '';

    // TODO: Focussing makes the selection go to the start?!
  }

  @override
  Widget build(BuildContext context) {
    var subscriptionsModel = context.read<SubscriptionsModel>();

    var prefs = PrefService.of(context, listen: false);

    var defaultTheme = Theme.of(context);
    var searchTheme = defaultTheme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: defaultTheme.colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        iconTheme: defaultTheme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );

    return Theme(
      data: searchTheme,
      child: Scaffold(
        // Needed as we're nesting Scaffolds, which causes Flutter to calculate keyboard height incorrectly
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextField(
            controller: _queryController,
            focusNode: _focusNode,
            style: searchTheme.textTheme.titleLarge,
            textInputAction: TextInputAction.search,
          ),
          actions: [
            IconButton(icon: const Icon(Icons.clear), onPressed: () => _queryController.clear()),
            ScopedBuilder<SubscriptionsModel, Object, List<Subscription>>.transition(
              store: subscriptionsModel,
              onState: (_, state) {
                return AnimatedBuilder(
                  animation: _queryController,
                  builder: (context, child) {
                    var id = _queryController.text;

                    var currentlyFollowed = state.any((element) => element.id == id);
                    if (!currentlyFollowed) {
                      return IconButton(icon: const Icon(Icons.save), onPressed: () async {
                        await subscriptionsModel.toggleSubscribe(SearchSubscription(id: id, createdAt: DateTime.now()), currentlyFollowed);
                      });
                    }

                    return const IconButton(icon: Icon(Icons.save), onPressed: null);
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            MultiProvider(
              providers: [
                ChangeNotifierProvider<TweetContextState>(
                    create: (_) => TweetContextState(prefs.get(optionTweetsHideSensitive))),
              ],
              child: Expanded(
                  child: TweetSearchResultList<SearchUsersModel, UserWithExtra>(
                      queryController: _queryController,
                      store: context.read<SearchUsersModel>(),
                      searchFunction: (q) => context.read<SearchUsersModel>().searchUsers(q),
                      itemBuilder: (context, user) => UserTile(user: UserSubscription.fromUser(user)))),
            )
          ],
        ),
      ),
    );
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class TweetSearchResultList<S extends Store<Object, List<T>>, T> extends StatefulWidget {
  final TextEditingController queryController;
  final S store;
  final Future<void> Function(String query) searchFunction;
  final ItemWidgetBuilder<T> itemBuilder;

  const TweetSearchResultList({Key? key, required this.queryController, required this.store, required this.searchFunction, required this.itemBuilder})
      : super(key: key);

  @override
  State<TweetSearchResultList<S, T>> createState() => _TweetSearchResultListState<S, T>();
}

class _TweetSearchResultListState<S extends Store<Object, List<T>>, T> extends State<TweetSearchResultList<S, T>> {
  Timer? _debounce;
  String? _previousQuery = '';

  @override
  void initState() {
    super.initState();

    widget.queryController.addListener(() {
      var query = widget.queryController.text;
      if (query == _previousQuery) {
        return;
      }

      // If the current query is different from the last render's query, search
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      // Debounce the search, so we don't make a request per keystroke
      _debounce = Timer(const Duration(milliseconds: 750), () async {
        fetchResults();
      });
    });

    fetchResults();
  }

  void fetchResults() {
    if (mounted) {
      var query = widget.queryController.text;
      _previousQuery = query;
      widget.searchFunction(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<S, Object, List<T>>.transition(
      store: widget.store,
      onLoading: (_) => const Center(child: CircularProgressIndicator()),
      onError: (_, error) => FullPageErrorWidget(
        error: error,
        stackTrace: null,
        prefix: L10n.of(context).unable_to_load_the_search_results,
        onRetry: () => fetchResults(),
      ),
      onState: (_, items) {
        if (items.isEmpty) {
          return Center(child: Text(L10n.of(context).no_results));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, items[index]);
          },
        );
      },
    );
  }
}