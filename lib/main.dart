import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/profile.dart';
import 'package:fritter/status.dart';
import 'package:pref/pref.dart';
import 'package:uni_links2/uni_links.dart';

import 'constants.dart';
import 'database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Repository connection = Repository();
  connection.migrate();

  final prefService = await PrefServiceShared.init(prefix: 'pref_');

  runApp(PrefService(
      child: MyApp(),
      service: prefService
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _trueBlack = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Enable "true blacks" if the preference is set
    setState(() {
      this._trueBlack = PrefService.of(context).get(OPTION_THEME_TRUE_BLACK) ?? false;
    });

    // Whenever the "true black" preference is toggled, apply the toggle
    PrefService.of(context).addKeyListener(OPTION_THEME_TRUE_BLACK, () {
      setState(() {
        this._trueBlack = PrefService.of(context).get(OPTION_THEME_TRUE_BLACK);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FlexSchemeData fritterColorScheme = FlexSchemeData(
      name: 'Fritter blue',
      description: 'Blue theme based on the Twitter color scheme',
      light: FlexSchemeColor(
        primary: Colors.blue,
        primaryVariant: Color(0xFF320019),
        secondary: Colors.blue[500]!,
        secondaryVariant: Color(0xFF002411),
      ),
      dark: FlexSchemeColor(
        primary: Colors.blue,
        primaryVariant: Color(0xFF775C69),
        secondary: Colors.blue[500]!,
        secondaryVariant: Color(0xFF5C7267),
      ),
    );

    return MaterialApp(
      title: 'Fritter',
      theme: FlexColorScheme.light(colors: fritterColorScheme.light).toTheme,
      darkTheme: FlexColorScheme.dark(colors: fritterColorScheme.dark, darkIsTrueBlack: _trueBlack).toTheme,
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
  String? _page;

  late String _username;
  late String _statusId;

  late StreamSubscription _sub;

  void handleInitialLink(Uri link) {
    // Parse the link
    if (link.pathSegments.length == 1) {
      // Assume it's a username
      setState(() {
        _page = 'profile';
        _username = link.pathSegments.first;
      });
      return;
    }

    if (link.pathSegments.length == 3) {
      // Assume it's a tweet
      var username = link.pathSegments[0];
      var statusId = link.pathSegments[2];

      setState(() {
        _page = 'status';
        _username = username;
        _statusId = statusId;
      });
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
      _sub = uriLinkStream.listen((link) => handleInitialLink(link!), onError: (err) {
        // TODO: Handle exception by warning the user their action did not succeed
        int i = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 'profile':
        return ProfileScreen(username: _username);
      case 'status':
        return StatusScreen(username: _username, id: _statusId);
      default:
        return HomeScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) {
      _sub.cancel();
    }
  }
}