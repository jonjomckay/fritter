import 'dart:async';

import 'package:fritter/profile.dart';
import 'package:flutter/material.dart';
import 'package:fritter/status.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fritter',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,

        // TODO: These are only required due to https://github.com/flutter/flutter/issues/19089
        accentColor: Colors.blue[500],
        toggleableActiveColor: Colors.blue[500],
        textSelectionColor: Colors.blue[200],
      ),
      themeMode: ThemeMode.system,
      home: DefaultPage(),
    );
  }
}


class DefaultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    getInitialLink().then((value) {
      // Attach a listener to the stream
      _sub = getUriLinksStream().listen((Uri link) {
        // Parse the link
        if (link.pathSegments.length == 1) {
          // Assume it's a username
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: link.pathSegments.first)));
          return;
        }

        if (link.pathSegments.length == 3) {
          // Assume it's a tweet
          var username = link.pathSegments[0];
          var statusId = link.pathSegments[2];

          Navigator.push(context, MaterialPageRoute(builder: (context) => StatusScreen(username: username, id: statusId)));
          return;
        }
      }, onError: (err) {
        // TODO: Handle exception by warning the user their action did not succeed
        int i = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(username: 'jonjomckay');
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) {
      _sub.cancel();
    }
  }
}