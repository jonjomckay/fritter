import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';

import 'models.dart';
import 'user.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;

  List<Tweet> _tweets = [];
  List<User> _users = [];
  bool _loading = false;
  String _oldSearch;

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
      _debounce.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // If the query is the same as before, do nothing
      if (_searchQuery.text == _oldSearch) {
        return;
      }

      setState(() {
        _loading = true;
      });

      if (_searchQuery.text.isEmpty) {
        setState(() {
          _loading = false;
          _tweets = [];
          _users = [];
          _oldSearch = null;
        });
      } else {
        var tweetSearch = TwitterClient.searchTweets(_searchQuery.text);
        var usersSearch = TwitterClient.searchUsers(_searchQuery.text);

        Future.wait([tweetSearch, usersSearch]).then((results) {
          var tweets = results[0];
          var users = results[1];

          setState(() {
            _loading = false;
            _tweets = tweets.toList();
            _users = users.toList();
            _oldSearch = _searchQuery.text;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                    itemBuilder: (context, index) => TweetTile(tweet: _tweets[index]),
                  ),
            _users.isEmpty && _oldSearch != null
                ? Center(child: Text('No results'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _users.length,
                    itemBuilder: (context, index) => UserTile(user: _users[index]),
                  )
          ]),
        ),
      ),
    );
  }
}
