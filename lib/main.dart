import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fritter/catcher/errors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_model.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/import_data_model.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/saved/saved_tweet_model.dart';
import 'package:fritter/search/search.dart';
import 'package:fritter/search/search_model.dart';
import 'package:fritter/settings/_general.dart';
import 'package:fritter/settings/settings.dart';
import 'package:fritter/settings/settings_export_screen.dart';
import 'package:fritter/status.dart';
import 'package:fritter/subscriptions/_import.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:fritter/tweet/_video.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uni_links2/uni_links.dart';

import 'WebFlowAuth/webFlowAuth_model.dart';

Future checkForUpdates() async {
  Logger.root.info('Checking for updates');

  try {
    var response = await http.get(Uri.https('fritter.cc', '/api/data.json'));
    if (response.statusCode == 200) {
      var package = await PackageInfo.fromPlatform();
      var result = jsonDecode(response.body);
      var prefs = await SharedPreferences.getInstance();

      var flavor = getFlavor();

      var release = result['versions'][flavor]['stable'];
      var latest = release['versionCode'] as int;

      Logger.root.info('The latest version is $latest, and we are on ${package.buildNumber}');

      if (int.parse(package.buildNumber) > latest) {
        var ignoredKey = 'updates.ignore.$latest';

        // If the user wants to ignore this version, do so
        var ignored = prefs.getBool(ignoredKey) ?? false;
        if (ignored) {
          log('Ignoring update to $latest');
          return;
        }

        var details = NotificationDetails(
            android: AndroidNotificationDetails('updates', 'Updates',
                channelDescription: 'When a new app update is available',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: false,
                actions: [AndroidNotificationAction(ignoredKey, 'Ignore this version')]));

        if (flavor == 'github') {
          await FlutterLocalNotificationsPlugin().show(
              0, 'An update for Fritter is available! 🚀', 'Tap to download ${release['version']}', details,
              payload: release['apk']);
        } else {
          await FlutterLocalNotificationsPlugin().show(0, 'An update for Fritter is available! 🚀',
              'Update to ${release['version']} through your F-Droid client', details,
              payload: 'https://f-droid.org/packages/com.jonjomckay.fritter/');
        }
      }
    } else {
      Catcher.reportSyntheticException(UnableToCheckForUpdatesException(response.body));
    }
  } catch (e, stackTrace) {
    Logger.root.severe('Unable to check for updates');
    Catcher.reportException(e, stackTrace);
  }
}

class UnableToCheckForUpdatesException implements SyntheticException {
  final String body;

  UnableToCheckForUpdatesException(this.body);

  @override
  String toString() {
    return 'Unable to check for updates: {body: $body}';
  }
}

setTimeagoLocales() {
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('az', timeago.AzMessages());
  timeago.setLocaleMessages('ca', timeago.CaMessages());
  timeago.setLocaleMessages('cs', timeago.CsMessages());
  timeago.setLocaleMessages('da', timeago.DaMessages());
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('dv', timeago.DvMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('es', timeago.EsMessages());
  timeago.setLocaleMessages('fa', timeago.FaMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('gr', timeago.GrMessages());
  timeago.setLocaleMessages('he', timeago.HeMessages());
  timeago.setLocaleMessages('he', timeago.HeMessages());
  timeago.setLocaleMessages('hi', timeago.HiMessages());
  timeago.setLocaleMessages('id', timeago.IdMessages());
  timeago.setLocaleMessages('it', timeago.ItMessages());
  timeago.setLocaleMessages('ja', timeago.JaMessages());
  timeago.setLocaleMessages('km', timeago.KmMessages());
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  timeago.setLocaleMessages('ku', timeago.KuMessages());
  timeago.setLocaleMessages('mn', timeago.MnMessages());
  timeago.setLocaleMessages('ms_MY', timeago.MsMyMessages());
  timeago.setLocaleMessages('nb_NO', timeago.NbNoMessages());
  timeago.setLocaleMessages('nl', timeago.NlMessages());
  timeago.setLocaleMessages('nn_NO', timeago.NnNoMessages());
  timeago.setLocaleMessages('pl', timeago.PlMessages());
  timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
  timeago.setLocaleMessages('ro', timeago.RoMessages());
  timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('sv', timeago.SvMessages());
  timeago.setLocaleMessages('ta', timeago.TaMessages());
  timeago.setLocaleMessages('th', timeago.ThMessages());
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  timeago.setLocaleMessages('uk', timeago.UkMessages());
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
  timeago.setLocaleMessages('zh', timeago.ZhMessages());
}

Future<void> handleNotificationCallback(NotificationResponse response) async {
  var actionId = response.actionId;
  if (actionId != null && actionId.startsWith('updates.ignore.')) {
    log('Setting $actionId');
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(actionId, true);
  }
}

Future<void> main() async {
  Logger.root.onRecord.listen((event) async {
    log(event.message, error: event.error, stackTrace: event.stackTrace);
  });

  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  setTimeagoLocales();

  final prefService = await PrefServiceShared.init(prefix: 'pref_', defaults: {
    optionDisableScreenshots: false,
    optionDownloadPath: '',
    optionDownloadType: optionDownloadTypeAsk,
    optionHomePages: defaultHomePages.map((e) => e.id).toList(),
    optionLocale: optionLocaleDefault,
    optionMediaSize: 'medium',
    optionMediaDefaultMute: true,
    optionNonConfirmationBiasMode: false,
    optionShouldCheckForUpdates: true,
    optionSubscriptionGroupsOrderByAscending: true,
    optionSubscriptionGroupsOrderByField: 'name',
    optionSubscriptionOrderByAscending: true,
    optionSubscriptionOrderByField: 'name',
    optionThemeMode: 'system',
    optionThemeTrueBlack: false,
    optionThemeColorScheme: 'aquaBlue',
    optionTweetsHideSensitive: false,
    optionUserTrendsLocations: jsonEncode({
      'active': {'name': 'Worldwide', 'woeid': 1},
      'locations': [
        {'name': 'Worldwide', 'woeid': 1}
      ]
    }),
    optionPasswordTwitterAcc:'',
    optionLoginNameTwitterAcc:'',
    optionEmailTwitterAcc:'',

  });

  TripleObserver.addListener((triple) {
    if (triple.error != null) {
      Catcher.reportException(triple.error);
    }
  });

  try {
    await SentryFlutter.init((options) async {
      // The native SDK tries to contact Sentry on startup, which we can't do as Sentry is opt-in, so check first
      options.autoInitializeNativeSdk = prefService.get(optionErrorsSentryEnabled) ?? false;
      options.attachStacktrace = true;
      options.dsn = 'https://d29f676b4a1d4a21bbad5896841d89bf@o856922.ingest.sentry.io/5820282';
      options.sendDefaultPii = false;
      options.enableAppLifecycleBreadcrumbs = true;
      options.enableAutoNativeBreadcrumbs = true;

      options.beforeSend = (event, {hint}) {
        var enabled = prefService.get(optionErrorsSentryEnabled);
        if (enabled == null || enabled == false) {
          return null;
        }

        // We don't want to report SocketExceptions as there's so many of them, and they're not super useful
        if (event.throwable is SocketException) {
          return null;
        }

        return event;
      };
    }, appRunner: () async {
      var deviceInfo = DeviceInfoPlugin();

      Sentry.configureScope((scope) async {
        scope.setTag('flavor', getFlavor());

        if (Platform.isAndroid) {
          var androidDeviceInfo = await deviceInfo.androidInfo;
          scope.setTag('versionSdk', androidDeviceInfo.version.sdkInt.toString());
        }
      });

      if (Platform.isAndroid) {
        FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

        const InitializationSettings settings =
        InitializationSettings(android: AndroidInitializationSettings('@drawable/ic_notification'));

        await notifications
            .initialize(settings, onDidReceiveBackgroundNotificationResponse: handleNotificationCallback,
            onDidReceiveNotificationResponse: (response) async {
              var payload = response.payload;
              if (payload != null && payload.startsWith('https://')) {
                await openUri(payload);
              }
            });

        var flavor = getFlavor();
        var shouldCheckForUpdates = prefService.get(optionShouldCheckForUpdates);
        if (flavor != 'play' && shouldCheckForUpdates) {
          // Don't check for updates for the Play Store build or if user disabled it.
          checkForUpdates();
        }
      }

      // Run the migrations early, so models work. We also do this later on so we can display errors to the user
      try {
        await Repository().migrate();
      } catch (_) {
        // Ignore, as we'll catch it later instead
      }

      var importDataModel = ImportDataModel();

      var groupsModel = GroupsModel(prefService);
      await groupsModel.reloadGroups();

      var homeModel = HomeModel(prefService, groupsModel);
      await homeModel.loadPages();

      var subscriptionsModel = SubscriptionsModel(prefService, groupsModel);
      await subscriptionsModel.reloadSubscriptions();

      var trendLocationModel = UserTrendLocationModel(prefService);

      var webFlowAuthModel = WebFlowAuthModel(prefService);

      runApp(PrefService(
          service: prefService,
          child: MultiProvider(
            providers: [
              Provider(create: (context) => groupsModel),
              Provider(create: (context) => homeModel),
              ChangeNotifierProvider(create: (context) => importDataModel),
              Provider(create: (context) => subscriptionsModel),
              Provider(create: (context) => SavedTweetModel()),
              Provider(create: (context) => SearchUsersModel()),
              Provider(create: (context) => trendLocationModel),
              Provider(create: (context) => TrendLocationsModel()),
              Provider(create: (context) => TrendsModel(trendLocationModel)),
              ChangeNotifierProvider(create: (_) => VideoContextState(prefService.get(optionMediaDefaultMute))),
              ChangeNotifierProvider(create: (context) => webFlowAuthModel),
            ],
            child: DevicePreview(
              enabled: !kReleaseMode,
              builder: (context) => const FritterApp(),
            ),
          )));
    });
  } catch (e, stackTrace) {
    Catcher.reportException(e, stackTrace);
    log('Unable to start Fritter', error: e, stackTrace: stackTrace);
  }
}

class FritterApp extends StatefulWidget {
  const FritterApp({Key? key}) : super(key: key);

  @override
  State<FritterApp> createState() => _FritterAppState();
}

class _FritterAppState extends State<FritterApp> {
  static final log = Logger('_MyAppState');

  String _themeMode = 'system';
  bool _trueBlack = false;
  FlexScheme _colorScheme = FlexScheme.aquaBlue;
  Locale? _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var prefService = PrefService.of(context);

    void setLocale(String? locale) {
      if (locale == null || locale == optionLocaleDefault) {
        _locale = null;
      } else {
        var splitLocale = locale.split('-');
        if (splitLocale.length == 1) {
          _locale = Locale(splitLocale[0]);
        } else {
          _locale = Locale(splitLocale[0], splitLocale[1]);
        }
      }
    }

    void setColorScheme(String colorSchemeName) {
      _colorScheme = FlexScheme.values.byName(colorSchemeName);
    }

    // TODO: This doesn't work on iOS
    void setDisableScreenshots(final bool secureModeEnabled) async {
      if (secureModeEnabled) {
        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      } else {
        await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
      }
    }

    // Set any already-enabled preferences
    setState(() {
      setLocale(prefService.get<String>(optionLocale));
      _themeMode = prefService.get(optionThemeMode);
      _trueBlack = prefService.get(optionThemeTrueBlack);
      setColorScheme(prefService.get(optionThemeColorScheme));
      setDisableScreenshots(prefService.get(optionDisableScreenshots));
    });

    prefService.addKeyListener(optionShouldCheckForUpdates, () {
      setState(() {});
    });

    prefService.addKeyListener(optionLocale, () {
      setState(() {
        setLocale(prefService.get<String>(optionLocale));
      });
    });

    // Whenever the "true black" preference is toggled, apply the toggle
    prefService.addKeyListener(optionThemeTrueBlack, () {
      setState(() {
        _trueBlack = prefService.get(optionThemeTrueBlack);
      });
    });

    prefService.addKeyListener(optionThemeMode, () {
      setState(() {
        _themeMode = prefService.get(optionThemeMode);
      });
    });

    prefService.addKeyListener(optionThemeColorScheme, () {
      setState(() {
        setColorScheme(prefService.get(optionThemeColorScheme));
      });
    });

    prefService.addKeyListener(optionDisableScreenshots, () {
      setState(() {
        setDisableScreenshots(prefService.get(optionDisableScreenshots));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        log.warning('Unknown theme mode preference: $_themeMode');
        themeMode = ThemeMode.system;
        break;
    }

    return MaterialApp(
      localeListResolutionCallback: (locales, supportedLocales) {
        List supportedLocalesCountryCode = [];
        for (var item in supportedLocales) {
          supportedLocalesCountryCode.add(item.countryCode);
        }

        List supportedLocalesLanguageCode = [];
        for (var item in supportedLocales) {
          supportedLocalesLanguageCode.add(item.languageCode);
        }

        locales!;
        List localesCountryCode = [];
        for (var item in locales) {
          localesCountryCode.add(item.countryCode);
        }

        List localesLanguageCode = [];
        for (var item in locales) {
          localesLanguageCode.add(item.languageCode);
        }

        for (var i = 0; i < locales.length; i++) {
          if (supportedLocalesCountryCode.contains(localesCountryCode[i]) &&
              supportedLocalesLanguageCode.contains(localesLanguageCode[i])) {
            log.info('Yes country: ${localesCountryCode[i]}, ${localesLanguageCode[i]}');
            return Locale(localesLanguageCode[i], localesCountryCode[i]);
          } else if (supportedLocalesLanguageCode.contains(localesLanguageCode[i])) {
            log.info('Yes language: ${localesLanguageCode[i]}');
            return Locale(localesLanguageCode[i]);
          } else {
            log.info('Nothing');
          }
        }
        return const Locale('en');
      },
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.delegate.supportedLocales,
      locale: _locale ?? DevicePreview.locale(context),
      navigatorObservers: [SentryNavigatorObserver()],
      title: 'Fritter',
      theme: FlexThemeData.light(
        scheme: _colorScheme,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        tabBarStyle: FlexTabBarStyle.flutterDefault,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: false,
        appBarStyle: FlexAppBarStyle.primary,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: _colorScheme,
        darkIsTrueBlack: _trueBlack,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        tabBarStyle: FlexTabBarStyle.flutterDefault,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: false,
        appBarStyle: _trueBlack ? FlexAppBarStyle.surface : FlexAppBarStyle.primary,
      ),
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        routeHome: (context) => const DefaultPage(),
        routeGroup: (context) => const GroupScreen(),
        routeProfile: (context) => const ProfileScreen(),
        routeSearch: (context) => const SearchScreen(),
        routeSettings: (context) => const SettingsScreen(),
        routeSettingsExport: (context) => const SettingsExportScreen(),
        routeSettingsHome: (context) => const SettingsScreen(initialPage: 'home'),
        routeStatus: (context) => const StatusScreen(),
        routeSubscriptionsImport: (context) => const SubscriptionImportScreen()
      },
      builder: (context, child) {
        // Replace the default red screen of death with a slightly friendlier one
        ErrorWidget.builder = (FlutterErrorDetails details) => FullPageErrorWidget(
          error: details.exception,
          stackTrace: details.stack,
          prefix: L10n.of(context).something_broke_in_fritter,
        );

        return DevicePreview.appBuilder(context, child ?? Container());
      },
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  Object? _migrationError;
  StackTrace? _migrationStackTrace;
  StreamSubscription? _sub;

  void handleInitialLink(Uri link) {
    // Assume it's a username if there's only one segment (or two segments with the second empty, meaning the URI ends with /)
    if (link.pathSegments.length == 1 || (link.pathSegments.length == 2 && link.pathSegments.last.isEmpty)) {
      Navigator.pushReplacementNamed(context, routeProfile,
          arguments: ProfileScreenArguments.fromScreenName(link.pathSegments.first));
      return;
    }

    if (link.pathSegments.length == 2) {
      var secondSegment = link.pathSegments[1];

      // https://twitter.com/i/redirect?url=https%3A%2F%2Ftwitter.com%2Fi%2Ftopics%2Ftweet%2F1447290060123033601
      if (secondSegment == 'redirect') {
        // This is a redirect URL, so we should extract it and use that as our initial link instead
        var redirect = link.queryParameters['url'];
        if (redirect == null) {
          // TODO
          return;
        }

        handleInitialLink(Uri.parse(redirect));
        return;
      }
    }

    if (link.pathSegments.length == 3) {
      var segment2 = link.pathSegments[1];
      if (segment2 == 'status') {
        // Assume it's a tweet
        var username = link.pathSegments[0];
        var statusId = link.pathSegments[2];

        Navigator.pushReplacementNamed(context, routeStatus,
            arguments: StatusScreenArguments(
              id: statusId,
              username: username,
            ));
        return;
      }
    }

    if (link.pathSegments.length == 4) {
      var segment2 = link.pathSegments[1];
      var segment3 = link.pathSegments[2];
      var segment4 = link.pathSegments[3];

      // https://twitter.com/i/topics/tweet/1447290060123033601
      if (segment2 == 'topics' && segment3 == 'tweet') {
        Navigator.pushReplacementNamed(context, routeStatus,
            arguments: StatusScreenArguments(id: segment4, username: null));
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Run the database migrations
    Repository().migrate().catchError((e, s) {
      setState(() {
        _migrationError = e;
        _migrationStackTrace = s;
      });
    });

    getInitialUri().then((link) {
      if (link != null) {
        handleInitialLink(link);
      }

      // Attach a listener to the stream
      _sub = uriLinkStream.listen((link) => handleInitialLink(link!), onError: (err) {
        // TODO: Handle exception by warning the user their action did not succeed
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_migrationError != null || _migrationStackTrace != null) {
      return ScaffoldErrorWidget(
          error: _migrationError,
          stackTrace: _migrationStackTrace,
          prefix: L10n.of(context).unable_to_run_the_database_migrations);
    }

    return WillPopScope(
        onWillPop: () async {
          var result = await showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                    title: Text(L10n.current.are_you_sure),
                    content: Text(L10n.current.confirm_close_fritter),
                    actions: [
                      TextButton(
                        child: Text(L10n.current.no),
                        onPressed: () => Navigator.pop(c, false),
                      ),
                      TextButton(
                        child: Text(L10n.current.yes),
                        onPressed: () => Navigator.pop(c, true),
                      ),
                    ],
                  ));

          return result ?? false;
        },
        child: const HomeScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }
}
