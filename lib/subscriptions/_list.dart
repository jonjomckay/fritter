import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

class SubscriptionUsers extends StatefulWidget {
  const SubscriptionUsers({Key? key}) : super(key: key);

  @override
  _SubscriptionUsersState createState() => _SubscriptionUsersState();
}

class _SubscriptionUsersState extends State<SubscriptionUsers> {
  @override
  Widget build(BuildContext context) {
    var model = context.read<UsersModel>();
    if (model.subscriptions.isEmpty) {
      return SliverToBoxAdapter(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text('¯\\_(ツ)_/¯', style: TextStyle(fontSize: 32)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(L10n.of(context).no_subscriptions_try_searching_or_importing_some,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        child: Text(L10n.of(context).import_from_twitter),
                        onPressed: () => Navigator.pushNamed(context, routeSubscriptionsImport),
                      ),
                    )
                  ])));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        var user = model.subscriptions[index];

        return UserTile(
          id: user.id.toString(),
          name: user.name,
          screenName: user.screenName,
          imageUri: user.profileImageUrlHttps,
          verified: user.verified,
        );
      }, childCount: model.subscriptions.length),
    );
  }
}
