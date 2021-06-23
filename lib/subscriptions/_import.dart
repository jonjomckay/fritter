import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/home_model.dart';

// TODO: Is this needed?
class SubscriptionImportScreen extends StatelessWidget {
  const SubscriptionImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SubscriptionImport();
  }
}


class _SubscriptionImport extends StatefulWidget {
  const _SubscriptionImport({Key? key}) : super(key: key);

  @override
  __SubscriptionImportState createState() => __SubscriptionImportState();
}

class __SubscriptionImportState extends State<_SubscriptionImport> {
  String? _screenName;
  int _total = 0;

  Future? _future;

  Future importStuff() async {
    setState(() {
      _future = Future(() async {
        setState(() {
          _total = 0;
        });

        var screenName = _screenName;
        if (screenName == null || screenName.isEmpty) {
          return;
        }

        int? cursor;
        List<User> users = [];

        var model = HomeModel();

        while(true) {
          var response = await Twitter.getProfileFollows(screenName, 'following', cursor: cursor);

          users.addAll(response.users);
          cursor = response.cursorBottom;

          setState(() {
            _total = users.length;
          });

          if (cursor == 0 || cursor == -1) {
            break;
          }
        }

        await model.importData({
          TABLE_SUBSCRIPTION: [
            ...users.map((e) => Subscription(
              id: e.idStr!,
              name: e.name!,
              profileImageUrlHttps: e.profileImageUrlHttps,
              screenName: e.screenName!,
              verified: e.verified ?? false
            ))
          ]
        });

        await model.refreshSubscriptionUsers();

        log('Finished with $_total users');
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import subscriptions'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('This functionality is currently in beta!', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('To import subscriptions from an existing Twitter account, enter your username below.'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('Please note that the method Fritter uses to import subscriptions is heavily rate-limited by Twitter, so this may fail if you have a lot of followed accounts.'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter your Twitter username',
                  helperText: 'Your profile must be public, otherwise the import will not work',
                  prefixText: '@',
                  labelText: 'Username'
                ),
                maxLength: 15,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_]+'))
                ],
                onChanged: (value) {
                  setState(() {
                    _screenName = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    var error = snapshot.error;
                    if (error != null) {
                      // TODO: This doesn't work
                      return Text('oops');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Press start');
                      case ConnectionState.waiting:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                            Text('Have $_total users')
                          ],
                        );
                      default:
                        return Text('Finished with $_total users');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await importStuff();
        },
      ),
    );
  }
}
