import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

void showFeedSettings(BuildContext context, String group) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        var theme = Theme.of(context);

        return SizedBox(
          height: 220,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: Text(L10n.of(context).filters),
                  tileColor: theme.colorScheme.primary,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
                    child: Text(
                      L10n.of(context).note_due_to_a_twitter_limitation_not_all_tweets_may_be_included,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    )),
                Consumer<GroupModel>(builder: (context, model, child) {
                  return FutureBuilderWrapper<SubscriptionGroupSettings>(
                    future: model.loadSubscriptionGroupSettings(group),
                    onError: (error, stackTrace) => InlineErrorWidget(error: error),
                    onReady: (settings) => Column(
                      children: [
                        CheckboxListTile(
                            title: Text(
                              L10n.of(context).include_replies,
                            ),
                            value: settings.includeReplies,
                            onChanged: (value) async {
                              await model.toggleSubscriptionGroupIncludeReplies(group, value ?? false);
                            }),
                        CheckboxListTile(
                            title: Text(
                              L10n.of(context).include_retweets,
                            ),
                            value: settings.includeRetweets,
                            onChanged: (value) async {
                              await model.toggleSubscriptionGroupIncludeRetweets(group, value ?? false);
                            }),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        );
      });
}