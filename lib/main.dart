import 'dart:async';
import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/profile.dart';
import 'package:fritter/status.dart';
import 'package:pref/pref.dart';
import 'package:uni_links2/uni_links.dart';

import 'constants.dart';
import 'database/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Repository connection = Repository();
  connection.migrate();

  final prefService = await PrefServiceShared.init(prefix: 'pref_', defaults: {
    OPTION_THEME_MODE: 'system',
    OPTION_THEME_TRUE_BLACK: false
  });

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
  String _themeMode = 'system';
  bool _trueBlack = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    var prefService = PrefService.of(context);

    // Set any already-enabled preferences
    setState(() {
      this._themeMode = prefService.get(OPTION_THEME_MODE) ?? 'system';
      this._trueBlack = prefService.get(OPTION_THEME_TRUE_BLACK) ?? false;
    });

    // Whenever the "true black" preference is toggled, apply the toggle
    prefService.addKeyListener(OPTION_THEME_TRUE_BLACK, () {
      setState(() {
        this._trueBlack = prefService.get(OPTION_THEME_TRUE_BLACK);
      });
    });

    prefService.addKeyListener(OPTION_THEME_MODE, () {
      setState(() {
        this._themeMode = prefService.get(OPTION_THEME_MODE);
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

    ThemeMode themeMode;
    switch (_themeMode) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        log('Unknown theme mode preference: '+ _themeMode);
        themeMode = ThemeMode.system;
        break;
    }

    return MaterialApp(
      title: 'Fritter',
      theme: FlexColorScheme.light(colors: fritterColorScheme.light).toTheme,
      darkTheme: FlexColorScheme.dark(colors: fritterColorScheme.dark, darkIsTrueBlack: _trueBlack).toTheme,
      themeMode: themeMode,
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
    // Assume it's a username if there's only one segment
    if (link.pathSegments.length == 1) {
      setState(() {
        _page = 'profile';
        _username = link.pathSegments.first;
      });
      return;
    }

    if (link.pathSegments.length > 2) {
      if (link.pathSegments[1] == 'status') {
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