import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/status.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:uni_links2/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'database/repository.dart';

Future checkForUpdates() async {
  log('Checking for updates');

  try {
    var response = await http.get(Uri.https('fritter.cc', '/api/data.json'));
    if (response.statusCode == 200) {
      var package = await PackageInfo.fromPlatform();
      var result = jsonDecode(response.body);

      const appFlavor = String.fromEnvironment('app.flavor');

      var flavor = appFlavor == ''
        ? 'fdroid'
        : appFlavor;

      var release = result['versions'][flavor]['stable'];
      var latest = release['versionCode'];

      log('The latest version is $latest, and we are on ${package.buildNumber}');

      if (int.parse(package.buildNumber) < latest) {
        var details = NotificationDetails(android: AndroidNotificationDetails(
            'updates', 'Updates', 'When a new app update is available',
            importance: Importance.max,
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
            priority: Priority.high,
            showWhen: false
        ));

        if (flavor == 'github') {
          await FlutterLocalNotificationsPlugin().show(
              0, 'An update for Fritter is available! 🚀',
              'Tap to download ${release['version']}', details,
              payload: release['apk']);
        } else {
          await FlutterLocalNotificationsPlugin().show(
              0, 'An update for Fritter is available! 🚀',
              'Update to ${release['version']} through your F-Droid client', details,
              payload: 'https://f-droid.org/packages/com.jonjomckay.fritter/'
          );
        }
      }
    } else {
      log('Unable to check for updates: ${response.body}');
    }
  } catch (e, stackTrace) {
    log('Unable to check for updates', error: e, stackTrace: stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Repository connection = Repository();
  connection.migrate();

  if (Platform.isAndroid) {
    FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

    final InitializationSettings settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon')
    );

    await notifications.initialize(settings, onSelectNotification: (payload) async {
      if (payload != null && payload.startsWith('https://')) {
        await launch(payload);
      }
    });

    checkForUpdates();
  }

  final prefService = await PrefServiceShared.init(prefix: 'pref_', defaults: {
    OPTION_MEDIA_SIZE: 'medium',
    OPTION_THEME_MODE: 'system',
    OPTION_THEME_TRUE_BLACK: false,
    OPTION_TRENDS_LOCATION: jsonEncode({
      'name': 'Worldwide',
      'woeid': 1
    }),
  });

  runApp(PrefService(
      child: ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: MyApp(),
      ),
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