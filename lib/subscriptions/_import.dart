import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionImportScreen extends StatefulWidget {
  const SubscriptionImportScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionImportScreenState createState() => _SubscriptionImportScreenState();
}

class _SubscriptionImportScreenState extends State<SubscriptionImportScreen> {
  String? _screenName;
  StreamController<int>? _streamController;

  Future importSubscriptions() async {
    setState(() {
      _streamController = StreamController();
    });

    try {
      var screenName = _screenName;
      if (screenName == null || screenName.isEmpty) {
        return;
      }

      _streamController?.add(0);

      int? cursor;
      int total = 0;

      var model = HomeModel();

      while (true) {
        var response = await Twitter.getProfileFollows(
          screenName,
          'following',
          cursor: cursor,
        );

        cursor = response.cursorBottom;
        total = total + response.users.length;

        await model.importData({
          TABLE_SUBSCRIPTION: [
            ...response.users.map((e) =>
                Subscription(
                    id: e.idStr!,
                    name: e.name!,
                    profileImageUrlHttps: e.profileImageUrlHttps,
                    screenName: e.screenName!,
                    verified: e.verified ?? false
                ))
          ]
        });

        _streamController?.add(total);

        if (cursor == 0 || cursor == -1) {
          break;
        }
      }

      await model.refreshSubscriptionUsers();
      _streamController?.close();
    } catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);
      _streamController?.addError(e, stackTrace);
    }
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
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'If you have any feedback on this feature, please leave it on '),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () async => launch('https://github.com/jonjomckay/fritter/issues/143'),
                      child: Text('the GitHub issue (#143)', style: TextStyle(
                        color: Colors.blue,
                      )),
                    )
                  ),
                    TextSpan(text: '. Selecting individual accounts to import, and assigning groups are both planned for the future already!')
                  ]
                )
              ),
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
                child: StreamBuilder(
                  stream: _streamController?.stream,
                  builder: (context, snapshot) {
                    var error = snapshot.error;
                    if (error != null) {
                      return EmojiErrorWidget(
                        emoji: '😢',
                        message: 'Unable to import',
                        errorMessage: error.toString()
                      );
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                            Text('Imported ${snapshot.data} users so far')
                          ],
                        );
                      default:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(Icons.check_circle, size: 36, color: Colors.green),
                            ),
                            Text('Finished with ${snapshot.data} users')
                          ],
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.import_export),
        onPressed: () async => await importSubscriptions(),
      ),
    );
  }
}
