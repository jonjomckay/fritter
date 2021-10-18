import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:catcher/catcher.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fritter/catcher/null_handler.dart';
import 'package:fritter/catcher/sentry_handler.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/settings/settings_export_screen.dart';
import 'package:fritter/status.dart';
import 'package:fritter/subscriptions/_import.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uni_links2/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

Future checkForUpdates() async {
  Logger.root.info('Checking for updates');

  try {
    var response = await http.get(Uri.https('fritter.cc', '/api/data.json'));
    if (response.statusCode == 200) {
      var package = await PackageInfo.fromPlatform();
      var result = jsonDecode(response.body);

      var flavor = getFlavor();
      if (flavor == 'play') {
        // Don't check for updates for the Play Store build
        return;
      }

      var release = result['versions'][flavor]['stable'];
      var latest = release['versionCode'];

      Logger.root.info('The latest version is $latest, and we are on ${package.buildNumber}');

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
      Logger.root.severe('Unable to check for updates: ${response.body}');
    }
  } catch (e, stackTrace) {
    Logger.root.severe('Unable to check for updates', e, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefService = await PrefServiceShared.init(prefix: 'pref_', defaults: {
    OPTION_MEDIA_SIZE: 'medium',
    OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_ASCENDING: false,
    OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_FIELD: 'name',
    OPTION_SUBSCRIPTION_ORDER_BY_ASCENDING: false,
    OPTION_SUBSCRIPTION_ORDER_BY_FIELD: 'name',
    OPTION_THEME_MODE: 'system',
    OPTION_THEME_TRUE_BLACK: false,
    OPTION_TRENDS_LOCATION: jsonEncode({
      'name': 'Worldwide',
      'woeid': 1
    }),
  });

  var sentryOptions = SentryOptions(dsn: 'https://d29f676b4a1d4a21bbad5896841d89bf@o856922.ingest.sentry.io/5820282');
  sentryOptions.sendDefaultPii = false;
  sentryOptions.attachStacktrace = true;

  var sentryClient = SentryClient(sentryOptions);
  var sentryHub = Hub(sentryOptions);
  sentryHub.bindClient(sentryClient);

  CatcherOptions catcherOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(),
    FritterSentryHandler(
      sentryHub: sentryHub,
      sentryEnabledStream: prefService.stream<bool?>(OPTION_ERRORS_SENTRY_ENABLED)
    )
  ], localizationOptions: [
    LocalizationOptions('en',
      dialogReportModeDescription: 'A crash report has been generated, and can be emailed to the Fritter developers to help fix the problem.\n\nThe report contains device-specific information, so please feel free to remove any information you may wish to not disclose!\n\nView our privacy policy at fritter.cc/privacy to see how your report is handled.',
      dialogReportModeTitle: 'Send report',
      dialogReportModeAccept: 'Send',
      dialogReportModeCancel: "Don't send"
    )
  ], explicitExceptionHandlersMap: {
    'SocketException': NullHandler()
  }, customParameters: {
    'flavor': getFlavor()
  });

  Catcher(
    debugConfig: catcherOptions,
    releaseConfig: catcherOptions,
    enableLogger: false,
    runAppFunction: () async {
      Logger.root.onRecord.listen((event) async {
        print(event.message);

        if (event.error != null) {
          print(event.error);
          print(event.stackTrace);
        }

        if (event.level.value >= 900) {
          // Don't report internal Catcher errors, as it'll cause a loop
          if (event.loggerName != 'Catcher') {
            Catcher.reportCheckedError(event.error, event.stackTrace);
          }
        }
      });

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

      // Run the migrations early, so models work. We also do this later on so we can display errors to the user
      await Repository().migrate();

      var homeModel = HomeModel(prefService);

      var groupModel = GroupModel(prefService);
      await groupModel.reloadGroups();

      var usersModel = UsersModel(prefService, groupModel);
      await usersModel.reloadSubscriptions();

      runApp(PrefService(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => groupModel),
              ChangeNotifierProvider(create: (context) => homeModel),
              ChangeNotifierProvider(create: (context) => usersModel),
            ],
            child: DevicePreview(
              enabled: !kReleaseMode,
              builder: (context) => MyApp(hub: sentryHub),
            ),
          ),
          service: prefService
      ));
    });
}

class MyApp extends StatefulWidget {
  final Hub hub;

  const MyApp({Key? key, required this.hub}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final log = Logger('_MyAppState');

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
        log.warning('Unknown theme mode preference: '+ _themeMode);
        themeMode = ThemeMode.system;
        break;
    }

    return MaterialApp(
      locale: DevicePreview.locale(context),
      navigatorKey: Catcher.navigatorKey,
      navigatorObservers: [
        SentryNavigatorObserver(hub: widget.hub)
      ],
      title: 'Fritter',
      theme: FlexColorScheme.light(colors: fritterColorScheme.light).toTheme,
      darkTheme: FlexColorScheme.dark(colors: fritterColorScheme.dark, darkIsTrueBlack: _trueBlack).toTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => DefaultPage(),
        ROUTE_GROUP: (context) => GroupScreen(),
        ROUTE_PROFILE: (context) => ProfileScreen(),
        ROUTE_SETTINGS: (context) => SettingsScreen(),
        ROUTE_SETTINGS_EXPORT: (context) => SettingsExportScreen(),
        ROUTE_STATUS: (context) => StatusScreen(),
        ROUTE_SUBSCRIPTIONS_IMPORT: (context) => SubscriptionImportScreen()
      },
      builder: (context, child) {
        // Replace the default red screen of death with a slightly friendlier one
        ErrorWidget.builder = (FlutterErrorDetails details) {
          log.severe('Something broke in Fritter.', details.exception, details.stack);

          return Scaffold(
            body: FullPageErrorWidget(error: details.exception, stackTrace: details.stack, prefix: 'Something broke in Fritter.'),
          );
        };

        return DevicePreview.appBuilder(context, child ?? Container());
      },
    );
  }
}

class DefaultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  late StreamSubscription _sub;

  void handleInitialLink(Uri link) {
    // Assume it's a username if there's only one segment
    if (link.pathSegments.length == 1) {
      Navigator.pushNamed(context, ROUTE_PROFILE, arguments: link.pathSegments.first);
      return;
    }

    if (link.pathSegments.length > 2) {
      if (link.pathSegments[1] == 'status') {
        // Assume it's a tweet
        var username = link.pathSegments[0];
        var statusId = link.pathSegments[2];

        Navigator.pushNamed(context, ROUTE_STATUS, arguments: StatusScreenArguments(
          id: statusId,
          username: username,
        ));
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
    // Run the database migrations
    return FutureBuilderWrapper<void>(
      future: Repository().migrate(),
      onError: (error, stackTrace) => ScaffoldErrorWidget(
        error: error,
        stackTrace: stackTrace,
        prefix: 'Unable to run the database migrations',
      ),
      onReady: (data) => HomeScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }
}