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

  bool _loading = false;
  List<Tweet> _tweets = [];
  List<User> _users = [];
  String _oldSearch;
  int _currentTab = 0;

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
          _oldSearch = '';
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
    Widget child;

    switch(_currentTab) {
      case 0:
        child = ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _tweets.length,
          itemBuilder: (context, index) {
            return TweetTile(tweet: _tweets[index]);
          },
        );
        break;
      case 1:
        child = ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return UserTile(user: _users[index]);
          },
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fritter'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: _tweets == null ? 'Tweets' : 'Tweets (${_tweets.length})'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
              label: _users == null ? 'Users' : 'Users (${_users.length})'
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _searchQuery,
                decoration: InputDecoration(
                    icon: Icon(Icons.search)
                ),
              ),
            ),
            Expanded(
              child: LoadingStack(
                loading: _loading,
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}