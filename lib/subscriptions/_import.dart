import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fritter/generated/l10n.dart';

class SubscriptionImportScreen extends StatefulWidget {
  const SubscriptionImportScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionImportScreenState createState() => _SubscriptionImportScreenState();
}

class _SubscriptionImportScreenState extends State<SubscriptionImportScreen> {
  String? _screenName;
  StreamController<int>? _streamController;

  Future importSubscriptions() async {
    setState(() {
      _streamController = StreamController();
    });

    try {
      var screenName = _screenName;
      if (screenName == null || screenName.isEmpty) {
        return;
      }

      _streamController?.add(0);

      int? cursor;
      int total = 0;

      // TODO: Test this still works
      var homeModel = context.read<HomeModel>();
      var groupModel = context.read<GroupModel>();
      var usersModel = context.read<UsersModel>();

      while (true) {
        var response = await Twitter.getProfileFollows(
          screenName,
          'following',
          cursor: cursor,
        );

        cursor = response.cursorBottom;
        total = total + response.users.length;

        await homeModel.importData({
          tableSubscription: [
            ...response.users.map((e) => Subscription(
                id: e.idStr!,
                name: e.name!,
                profileImageUrlHttps: e.profileImageUrlHttps,
                screenName: e.screenName!,
                verified: e.verified ?? false))
          ]
        });

        _streamController?.add(total);

        if (cursor == 0 || cursor == -1) {
          break;
        }
      }

      await groupModel.reloadGroups();
      await usersModel.reloadSubscriptions();
      await usersModel.refreshSubscriptionData();
      _streamController?.close();
    } catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);
      _streamController?.addError(e, stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).import_subscriptions),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                L10n.of(context).to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                L10n.of(context)
                    .please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: '${L10n.of(context).if_you_have_any_feedback_on_this_feature_please_leave_it_on} '),
                WidgetSpan(
                    child: InkWell(
                  onTap: () async => launch('https://github.com/jonjomckay/fritter/issues/143'),
                  child: const Text('the GitHub issue (#143)',
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                )),
                TextSpan(
                  text:
                      '. ${L10n.of(context).selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already}',
                )
              ])),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  hintText: L10n.of(context).enter_your_twitter_username,
                  helperText: L10n.of(context).your_profile_must_be_public_otherwise_the_import_will_not_work,
                  prefixText: '@',
                  labelText: L10n.of(context).username,
                ),
                maxLength: 15,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_]+'))],
                onChanged: (value) {
                  setState(() {
                    _screenName = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Center(
                child: StreamBuilder(
                  stream: _streamController?.stream,
                  builder: (context, snapshot) {
                    var error = snapshot.error;
                    if (error != null) {
                      return FullPageErrorWidget(
                        error: snapshot.error,
                        stackTrace: snapshot.stackTrace,
                        prefix: L10n.of(context).unable_to_import,
                      );
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                            Text(
                              L10n.of(context).imported_snapshot_data_users_so_far(
                                snapshot.data.toString(),
                              ),
                            )
                          ],
                        );
                      default:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.check_circle, size: 36, color: Colors.green),
                            ),
                            Text(
                              L10n.of(context).finished_with_snapshotData_users(
                                snapshot.data.toString(),
                              ),
                            )
                          ],
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.import_export),
        onPressed: () async => await importSubscriptions(),
      ),
    );
  }
}
