import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';

void showFeedSettings(BuildContext context, GroupModel model) {
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
                ScopedBuilder<GroupModel, Object, SubscriptionGroupGet>(
                  store: model,
                  onState: (_, state) {
                    return Column(
                      children: [
                        CheckboxListTile(
                            title: Text(
                              L10n.of(context).include_replies,
                            ),
                            value: model.state.includeReplies,
                            onChanged: (value) async {
                              await model.toggleSubscriptionGroupIncludeReplies(value ?? false);
                            }),
                        CheckboxListTile(
                            title: Text(
                              L10n.of(context).include_retweets,
                            ),
                            value: model.state.includeRetweets,
                            onChanged: (value) async {
                              await model.toggleSubscriptionGroupIncludeRetweets(value ?? false);
                            }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      });
}