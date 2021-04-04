import 'dart:async';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/options.dart';

import 'client.dart';
import 'tweet.dart';
import 'user.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  final _searchQuery = new TextEditingController();
  Timer? _debounce;
  List<Tweet> _tweets = [];
  List<User> _users = [];
  bool _loading = false;
  String? _oldSearch;

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 750), () {
      // If the query is the same as before, do nothing
      if (_searchQuery.text == _oldSearch) {
        return;
      }

      performSearch(_searchQuery.text);
    });
  }

  void performSearch(String query) {
    setState(() {
      _loading = true;
    });

    if (query.isEmpty) {
      setState(() {
        _loading = false;
        _tweets = [];
        _users = [];
        _oldSearch = null;
      });
    } else {
      var tweetSearch = Twitter.searchTweets(query);
      var usersSearch = Twitter.searchUsers(query);

      Future.wait([tweetSearch, usersSearch])
          .then((results) => setState(() {
                _tweets = results[0].cast<Tweet>().toList();
                _users = results[1].cast<User>().toList();
                _oldSearch = query;
              }))
          .catchError((e, stackTrace) {
            log('Unable to load the search results', error: e, stackTrace: stackTrace);

            _globalKey.currentState!.showSnackBar(SnackBar(
                content: Text('Something went wrong loading the search results! The error was: $e'),
                duration: Duration(days: 1),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () => performSearch(query),
                ),
              ));
          })
          .whenComplete(() => setState(() {
                _loading = false;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: TextField(
            controller: _searchQuery,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Search tweets and users'
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsScreen()));
                },
            )
          ],
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.comment)),
            Tab(icon: Icon(Icons.person)),
          ]),
        ),
        body: LoadingStack(
          loading: _loading,
          child: TabBarView(children: [
            _tweets.isEmpty && _oldSearch != null
                ? Center(child: Text('No results'))
                : ListView.builder(
              shrinkWrap: true,
              itemCount: _tweets.length,
              itemBuilder: (context, index) => TweetTile(tweet: _tweets[index], clickable: true),
            ),
            _users.isEmpty && _oldSearch != null
                ? Center(child: Text('No results'))
                : ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (context, index) {
                var user = _users[index];

                return UserTile(
                  id: user.idStr!,
                  name: user.name!,
                  screenName: user.screenName!,
                  imageUri: user.profileImageUrlHttps,
                );
              },
            )
          ]),
        )
      ),
    );
  }
}
