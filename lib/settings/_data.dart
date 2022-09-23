import 'dart:convert';
import 'dart:io';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/import_data_model.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/utils/legacy.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

const String legacyExportFileName = 'fritter.json';

class SettingsData {
  final Map<String, dynamic>? settings;
  final List<SearchSubscription>? searchSubscriptions;
  final List<UserSubscription>? userSubscriptions;
  final List<SubscriptionGroup>? subscriptionGroups;
  final List<SubscriptionGroupMember>? subscriptionGroupMembers;
  final List<SavedTweet>? tweets;

  SettingsData(
      {required this.settings,
        required this.searchSubscriptions,
        required this.userSubscriptions,
        required this.subscriptionGroups,
        required this.subscriptionGroupMembers,
        required this.tweets});

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
        settings: json['settings'],
        searchSubscriptions: json['searchSubscriptions'] != null
            ? List.from(json['searchSubscriptions']).map((e) => SearchSubscription.fromMap(e)).toList()
            : null,
        userSubscriptions: json['subscriptions'] != null
            ? List.from(json['subscriptions']).map((e) => UserSubscription.fromMap(e)).toList()
            : null,
        subscriptionGroups: json['subscriptionGroups'] != null
            ? List.from(json['subscriptionGroups']).map((e) => SubscriptionGroup.fromMap(e)).toList()
            : null,
        subscriptionGroupMembers: json['subscriptionGroupMembers'] != null
            ? List.from(json['subscriptionGroupMembers']).map((e) => SubscriptionGroupMember.fromMap(e)).toList()
            : null,
        tweets: json['tweets'] != null ? List.from(json['tweets']).map((e) => SavedTweet.fromMap(e)).toList() : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'settings': settings,
      'searchSubscriptions': searchSubscriptions?.map((e) => e.toMap()).toList(),
      'subscriptions': userSubscriptions?.map((e) => e.toMap()).toList(),
      'subscriptionGroups': subscriptionGroups?.map((e) => e.toMap()).toList(),
      'subscriptionGroupMembers': subscriptionGroupMembers?.map((e) => e.toMap()).toList(),
      'tweets': tweets?.map((e) => e.toMap()).toList()
    };
  }
}


class SettingsDataFragment extends StatelessWidget {
  static final log = Logger('SettingsDataFragment');

  final String legacyExportPath;

  const SettingsDataFragment({Key? key, required this.legacyExportPath}) : super(key: key);

  Future<void> _importFromFile(BuildContext context, File file) async {
    var content = jsonDecode(file.readAsStringSync());

    var importModel = context.read<ImportDataModel>();
    var groupModel = context.read<GroupsModel>();
    var prefs = PrefService.of(context);

    var data = SettingsData.fromJson(content);

    var settings = data.settings;
    if (settings != null) {
      prefs.fromMap(settings);
    }

    var dataToImport = <String, List<ToMappable>>{};

    var searchSubscriptions = data.searchSubscriptions;
    if (searchSubscriptions != null) {
      dataToImport[tableSearchSubscription] = searchSubscriptions;
    }

    var userSubscriptions = data.userSubscriptions;
    if (userSubscriptions != null) {
      dataToImport[tableSubscription] = userSubscriptions;
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

    await importModel.importData(dataToImport);
    await groupModel.reloadGroups();
    await context.read<SubscriptionsModel>().reloadSubscriptions();
    await context.read<SubscriptionsModel>().refreshSubscriptionData();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(L10n.of(context).data_imported_successfully),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.current.data)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(children: [
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
                                  await _importFromFile(context, file);
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
                        content: Column(
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
                      );
                    });
              } else {
                var path = await FlutterFileDialog.pickFile(params: const OpenFileDialogParams());
                if (path != null) {
                  await _importFromFile(context, File(path));
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
        ]),
      ),
    );
  }
}
