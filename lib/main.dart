import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fritter/profile.dart';
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

  void handleInitialLink(Uri link) {
    // Parse the link
    if (link.pathSegments.length == 1) {
      // Assume it's a username
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: link.pathSegments.first)), (_) => false);
      return;
    }

    if (link.pathSegments.length == 3) {
      // Assume it's a tweet
      var username = link.pathSegments[0];
      var statusId = link.pathSegments[2];

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StatusScreen(username: username, id: statusId)), (_) => false);
      return;
    }
  }

  @override
  void initState() {
    super.initState();

    getInitialUri().then((link) {
      if (link != null) {
        handleInitialLink(link);
      }

      // Attach a listener to the stream
      _sub = getUriLinksStream().listen((link) => handleInitialLink(link), onError: (err) {
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