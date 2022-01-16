import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:catcher/catcher.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

String getFlavor() {
  const flavor = String.fromEnvironment('app.flavor');

  if (flavor == '') {
    return 'fdroid';
  }

  return flavor;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static final log = Logger('_OptionsScreenState');

  String _createVersionString(PackageInfo packageInfo) {
    return 'v${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future _importFromFile(File file) async {
    var content = jsonDecode(file.readAsStringSync());

    var homeModel = context.read<HomeModel>();
    var usersModel = context.read<UsersModel>();
    var groupModel = context.read<GroupModel>();
    var prefs = PrefService.of(context);

    var data = SettingsData.fromJson(content);

    var settings = data.settings;
    if (settings != null) {
      prefs.fromMap(settings);
    }

    var dataToImport = <String, List<ToMappable>>{};

    var subscriptions = data.subscriptions;
    if (subscriptions != null) {
      dataToImport[tableSubscription] = subscriptions;
    }

    var subscriptionGroups = data.subscriptionGroups;
    if (subscriptionGroups != null) {
      dataToImport[tableSubscriptionGroup] = subscriptionGroups;
    }

    var subscriptionGroupMembers = data.subscriptionGroupMembers;
    if (subscriptionGroupMembers != null) {
      dataToImport[tableSubscriptionGroupMember] = subscriptionGroupMembers;
    }

    var tweets = data.tweets;
    if (tweets != null) {
      dataToImport[tableSavedTweet] = tweets;
    }

    await homeModel.importData(dataToImport);
    await groupModel.reloadGroups();
    await usersModel.reloadSubscriptions();
    await usersModel.refreshSubscriptionData();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(L10n.of(context).data_imported_successfully),
    ));
  }

  Future _sendPing() async {
    var deviceInfo = DeviceInfoPlugin();
    var packageInfo = await PackageInfo.fromPlatform();
    var prefService = PrefService.of(context);

    // If we've already reported using this build number, do nothing
    var helloBuild = prefService.get(optionHelloLastBuild);
    if (helloBuild != null && helloBuild == packageInfo.buildNumber) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(L10n.of(context).it_looks_like_you_have_already_said_hello_from_this_version_of_fritter),
      ));

      return;
    }

    Map<String, Object> metadata;

    if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;

      metadata = {
        'abis': info.supportedAbis,
        'device': info.device,
        'flavor': getFlavor(),
        'locale': Localizations.localeOf(context).languageCode,
        'os': 'android',
        'system': info.version.sdkInt.toString(),
        'version': packageInfo.buildNumber,
      };
    } else {
      var info = await deviceInfo.iosInfo;

      metadata = {
        'abis': [],
        'device': info.utsname.machine,
        'flavor': getFlavor(),
        'locale': Localizations.localeOf(context).languageCode,
        'os': 'ios',
        'system': info.systemVersion,
        'version': packageInfo.buildNumber,
      };
    }

    showDialog(
        context: context,
        builder: (context) {
          var content = JsonEncoder.withIndent(' ' * 2).convert(metadata);

          return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(L10n.of(context).cancel)),
                TextButton(
                    onPressed: () async {
                      var pingUri = 'https://fritter.jonjomckay.com/ping';

                      try {
                        var response = await http
                            .post(Uri.parse(pingUri), headers: {'Content-Type': 'application/json'}, body: content)
                            .timeout(const Duration(seconds: 10));

                        SnackBar snackBar;

                        if (response.statusCode == 200) {
                          snackBar = SnackBar(
                            content: Text(
                              L10n.of(context).thanks_for_helping_fritter,
                            ),
                          );

                          // Mark that we've said hello from this build version
                          await prefService.set(optionHelloLastBuild, packageInfo.buildNumber);
                        } else if (response.statusCode == 403) {
                          snackBar = SnackBar(
                            content: Text(
                              L10n.of(context).it_looks_like_you_have_already_sent_a_ping_recently,
                            ),
                          );
                        } else {
                          Catcher.reportCheckedError(
                              'Unable to send the ping because the status code was ${response.statusCode}', null);

                          snackBar = SnackBar(
                            content: Text(
                              L10n.of(context)
                                  .unable_to_send_the_ping_the_status_code_was_response_statusCode(response.statusCode),
                            ),
                          );
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } on TimeoutException catch (e, stackTrace) {
                        log.severe('Timed out trying to send the ping');
                        Catcher.reportCheckedError(e, stackTrace);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            L10n.of(context).timed_out_trying_to_send_the_ping,
                          ),
                        ));
                      } catch (e, stackTrace) {
                        log.severe('Unable to send the ping');
                        Catcher.reportCheckedError(e, stackTrace);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            L10n.of(context).unable_to_send_the_ping_e_to_string(e),
                          ),
                        ));
                      }

                      Navigator.pop(context);
                    },
                    child: Text(L10n.of(context).send))
              ],
              title: Text(L10n.of(context).say_hello),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.of(context)
                        .here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future,
                  ),
                  const SizedBox(height: 16),
                  Text(content, style: const TextStyle(fontFamily: 'monospace'))
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilderWrapper<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        onError: (error, stackTrace) => FullPageErrorWidget(
          error: error,
          stackTrace: stackTrace,
          prefix: L10n.of(context).unable_to_find_the_app_package_info,
        ),
        // Complete translation from here @ManeraKai
        onReady: (packageInfo) {
          var version = _createVersionString(packageInfo);

          return PrefPage(children: [
            PrefButton(
              child: Text(L10n.of(context).say_hello_emoji),
              title: Text(L10n.of(context).say_hello),
              subtitle: Text(
                L10n.of(context)
                    .send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development,
              ),
              onTap: _sendPing,
            ),
            PrefTitle(
              title: Text(L10n.of(context).general),
            ),
            PrefDropdown(
                fullWidth: false,
                title: Text(L10n.of(context).default_tab),
                subtitle: Text(
                  L10n.of(context).which_tab_is_shown_when_the_app_opens,
                ),
                pref: optionHomeInitialTab,
                items: homeTabs.map((e) => DropdownMenuItem(child: Text(e.title), value: e.id)).toList()),
            PrefDropdown(
                fullWidth: false,
                title: Text(L10n.of(context).media_size),
                subtitle: Text(
                  L10n.of(context).save_bandwidth_using_smaller_images,
                ),
                pref: optionMediaSize,
                items: [
                  DropdownMenuItem(
                    child: Text(L10n.of(context).disabled),
                    value: 'disabled',
                  ),
                  DropdownMenuItem(
                    child: Text(L10n.of(context).thumbnail),
                    value: 'thumb',
                  ),
                  DropdownMenuItem(
                    child: Text(L10n.of(context).small),
                    value: 'small',
                  ),
                  DropdownMenuItem(
                    child: Text(L10n.of(context).medium),
                    value: 'medium',
                  ),
                  DropdownMenuItem(
                    child: Text(L10n.of(context).large),
                    value: 'large',
                  ),
                ]),
            PrefTitle(title: Text(L10n.of(context).theme)),
            PrefDropdown(fullWidth: false, title: Text(L10n.of(context).theme), pref: optionThemeMode, items: [
              DropdownMenuItem(
                child: Text(L10n.of(context).system),
                value: 'system',
              ),
              DropdownMenuItem(
                child: Text(L10n.of(context).light),
                value: 'light',
              ),
              DropdownMenuItem(
                child: Text(L10n.of(context).dark),
                value: 'dark',
              ),
            ]),
            PrefSwitch(
              title: Text(L10n.of(context).true_black),
              pref: optionThemeTrueBlack,
              subtitle: Text(
                L10n.of(context).use_true_black_for_the_dark_mode_theme,
              ),
            ),
            PrefTitle(
              title: Text(L10n.of(context).data),
            ),
            PrefLabel(
              leading: const Icon(Icons.import_export),
              title: Text(L10n.of(context).import),
              subtitle: Text(L10n.of(context).import_data_from_another_device),
              onTap: () async {
                var isLegacy = await isLegacyAndroid();
                if (isLegacy) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(L10n.of(context).legacy_android_import),
                          actions: [
                            TextButton(
                              child: Text(L10n.of(context).cancel),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text(L10n.of(context).import),
                              onPressed: () async {
                                var file = File(await getLegacyPath(legacyExportFileName));
                                if (await file.exists()) {
                                  try {
                                    await _importFromFile(file);
                                  } catch (e, stackTrace) {
                                    log.severe('Unable to import the file on a legacy Android device');
                                    Catcher.reportCheckedError(e, stackTrace);

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('$e'),
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        L10n.of(context)
                                            .the_file_does_not_exist_please_ensure_it_is_located_at_file_path(
                                                file.path),
                                      ),
                                    ),
                                  );
                                }

                                Navigator.pop(context);
                              },
                            )
                          ],
                          content: FutureBuilderWrapper<String>(
                            future: getLegacyPath(legacyExportFileName),
                            onError: (error, stackTrace) => FullPageErrorWidget(
                                error: error, stackTrace: stackTrace, prefix: L10n.of(context).prefix),
                            onReady: (legacyExportPath) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  L10n.of(context)
                                      .your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 16),
                                Text(legacyExportPath, textAlign: TextAlign.left),
                                const SizedBox(height: 16),
                                Text(
                                  L10n.of(context)
                                      .please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below,
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  var path = await FlutterFileDialog.pickFile(params: const OpenFileDialogParams());
                  if (path != null) {
                    await _importFromFile(File(path));
                  }
                }
              },
            ),
            PrefLabel(
              leading: const Icon(Icons.save),
              title: Text(L10n.of(context).export),
              subtitle: Text(L10n.of(context).export_your_data),
              onTap: () => Navigator.pushNamed(context, routeSettingsExport),
            ),
            PrefTitle(title: Text(L10n.of(context).logging)),
            PrefCheckbox(
              title: Text(L10n.of(context).enable_sentry),
              subtitle: Text(
                L10n.of(context).whether_errors_should_be_reported_to_sentry,
              ),
              pref: optionErrorsSentryEnabled,
            ),
            PrefTitle(title: Text(L10n.of(context).about)),
            PrefLabel(
              leading: const Icon(Icons.info),
              title: Text(L10n.of(context).version),
              subtitle: Text(version),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: version));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(L10n.of(context).copied_version_to_clipboard),
                ));
              },
            ),
            PrefLabel(
              leading: const Icon(Icons.favorite),
              title: Text(L10n.of(context).contribute),
              subtitle: Text(L10n.of(context).help_make_fritter_even_better),
              onTap: () => launch('https://github.com/jonjomckay/fritter'),
            ),
            PrefLabel(
              leading: const Icon(Icons.bug_report),
              title: Text(L10n.of(context).report_a_bug),
              subtitle: Text(
                L10n.of(context).let_the_developers_know_if_something_is_broken,
              ),
              onTap: () => launch('https://github.com/jonjomckay/fritter/issues'),
            ),
            if (getFlavor() != 'play')
              PrefLabel(
                leading: const Icon(Icons.attach_money),
                title: Text(L10n.of(context).donate),
                subtitle: Text(L10n.of(context).help_support_fritters_future),
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text(L10n.of(context).donate),
                        children: [
                          SimpleDialogOption(
                            child: const ListTile(
                              leading: Icon(SimpleIcons.bitcoin),
                              title: Text('Bitcoin'),
                            ),
                            onPressed: () async {
                              await Clipboard.setData(const ClipboardData(text: '1DaXsBJVi41fgKkKcw2Ln8noygTbdD7Srg'));

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    L10n.of(context).copied_address_to_clipboard,
                                  ),
                                ),
                              );
                            },
                          ),
                          SimpleDialogOption(
                            child: const ListTile(
                              leading: Icon(SimpleIcons.github),
                              title: Text('GitHub'),
                            ),
                            onPressed: () => launch('https://github.com/sponsors/jonjomckay'),
                          ),
                          SimpleDialogOption(
                            child: const ListTile(
                              leading: Icon(SimpleIcons.liberapay),
                              title: Text('Liberapay'),
                            ),
                            onPressed: () => launch('https://liberapay.com/jonjomckay'),
                          ),
                          SimpleDialogOption(
                            child: const ListTile(
                              leading: Icon(SimpleIcons.paypal),
                              title: Text('PayPal'),
                            ),
                            onPressed: () => launch('https://paypal.me/jonjomckay'),
                          )
                        ],
                      );
                    }),
              ),
            PrefLabel(
              leading: const Icon(Icons.copyright),
              title: Text(L10n.of(context).licenses),
              subtitle: Text(L10n.of(context).all_the_great_software_used_by_fritter),
              onTap: () => showLicensePage(
                  context: context,
                  applicationName: L10n.of(context).fritter,
                  applicationVersion: version,
                  applicationLegalese: L10n.of(context).released_under_the_mit_license,
                  applicationIcon: Container(
                    margin: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48.0),
                      child: Image.asset(
                        'assets/icon.png',
                        height: 48.0,
                        width: 48.0,
                      ),
                    ),
                  )),
            ),
          ]);
        },
      ),
    );
  }
}
