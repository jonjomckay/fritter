import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

class SettingsExportScreen extends StatefulWidget {
  const SettingsExportScreen({Key? key}) : super(key: key);

  @override
  _SettingsExportScreenState createState() => _SettingsExportScreenState();
}

class _SettingsExportScreenState extends State<SettingsExportScreen> {
  bool _exportSettings = false;
  bool _exportSubscriptions = false;
  bool _exportSubscriptionGroups = false;
  bool _exportSubscriptionGroupMembers = false;
  bool _exportTweets = false;

  void toggleExportSubscriptionGroupMembersIfRequired() {
    if (_exportSubscriptionGroupMembers && (!_exportSubscriptions || !_exportSubscriptionGroups)) {
      setState(() {
        _exportSubscriptionGroupMembers = false;
      });
    }
  }

  void toggleExportSettings() {
    setState(() {
      _exportSettings = !_exportSettings;
    });
  }

  void toggleExportSubscriptions() {
    setState(() {
      _exportSubscriptions = !_exportSubscriptions;
    });

    toggleExportSubscriptionGroupMembersIfRequired();
  }

  void toggleExportSubscriptionGroups() {
    setState(() {
      _exportSubscriptionGroups = !_exportSubscriptionGroups;
    });

    toggleExportSubscriptionGroupMembersIfRequired();
  }

  void toggleExportSubscriptionGroupMembers() {
    setState(() {
      _exportSubscriptionGroupMembers = !_exportSubscriptionGroupMembers;
    });
  }

  void toggleExportTweets() {
    setState(() {
      _exportTweets = !_exportTweets;
    });
  }

  bool noExportOptionSelected() {
    return !(_exportSettings ||
        _exportSubscriptions ||
        _exportSubscriptionGroups ||
        _exportSubscriptionGroupMembers ||
        _exportTweets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).export),
      ),
      floatingActionButton: noExportOptionSelected()
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                var homeModel = context.read<HomeModel>();
                var groupModel = context.read<GroupModel>();
                var usersModel = context.read<UsersModel>();
                var prefs = PrefService.of(context);

                var settings = _exportSettings ? prefs.toMap() : null;

                var subscriptions = _exportSubscriptions ? usersModel.subscriptions : null;

                var subscriptionGroups = _exportSubscriptionGroups ? groupModel.groups : null;

                var subscriptionGroupMembers =
                    _exportSubscriptionGroupMembers ? await groupModel.listGroupMembers() : null;

                var tweets = _exportTweets ? await homeModel.listSavedTweets() : null;

                var data = SettingsData(
                    settings: settings,
                    subscriptions: subscriptions,
                    subscriptionGroups: subscriptionGroups,
                    subscriptionGroupMembers: subscriptionGroupMembers,
                    tweets: tweets);

                var exportData = jsonEncode(data.toJson());

                var isLegacy = await isLegacyAndroid();
                if (isLegacy) {
                  // This platform is too old to support a directory picker, so we just save the file to a predefined location
                  var fullPath = await getLegacyPath(legacyExportFileName);

                  await Directory(path.dirname(fullPath)).create(recursive: true);
                  await File(fullPath).writeAsString(exportData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        L10n.of(context).data_exported_to_fullPath(fullPath),
                      ),
                    ),
                  );
                } else {
                  var dateFormat = DateFormat('yyyy-MM-dd');
                  var fileName = 'fritter-${dateFormat.format(DateTime.now())}.json';

                  // This platform can support the directory picker, so display it
                  var path = await FlutterFileDialog.saveFile(
                      params:
                          SaveFileDialogParams(fileName: fileName, data: Uint8List.fromList(utf8.encode(exportData))));
                  if (path != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          L10n.of(context).data_exported_to_fileName(fileName),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
      body: FutureBuilderWrapper<bool>(
        future: isLegacyAndroid(),
        onError: (error, stackTrace) => FullPageErrorWidget(
          error: error,
          stackTrace: stackTrace,
          prefix: L10n.of(context).unable_to_check_if_this_is_a_legacy_Android_device,
        ),
        onReady: (isLegacy) {
          Widget legacyAndroidMessage = Container();

          // Check if the platform is too old to support a directory picker or not
          if (isLegacy) {
            legacyAndroidMessage = FutureBuilderWrapper<String>(
              future: getLegacyPath(legacyExportFileName),
              onError: (error, stackTrace) => InlineErrorWidget(error: error),
              onReady: (legacyExportPath) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                          L10n.of(context)
                              .your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text(legacyExportPath, textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  CheckboxListTile(
                      value: _exportSettings,
                      title: Text(L10n.of(context).export_settings),
                      onChanged: (v) => toggleExportSettings()),
                  CheckboxListTile(
                      value: _exportSubscriptions,
                      title: Text(L10n.of(context).export_subscriptions),
                      onChanged: (v) => toggleExportSubscriptions()),
                  CheckboxListTile(
                      value: _exportSubscriptionGroups,
                      title: Text(L10n.of(context).export_subscription_groups),
                      onChanged: (v) => toggleExportSubscriptionGroups()),
                  CheckboxListTile(
                      value: _exportSubscriptionGroupMembers,
                      title: Text(L10n.of(context).export_subscription_group_members),
                      onChanged: _exportSubscriptions && _exportSubscriptionGroups
                          ? (v) => toggleExportSubscriptionGroupMembers()
                          : null),
                  CheckboxListTile(
                      value: _exportTweets,
                      title: Text(L10n.of(context).export_tweets),
                      onChanged: (v) => toggleExportTweets()),
                ],
              ))),
              legacyAndroidMessage,
            ],
          );
        },
      ),
    );
  }
}
