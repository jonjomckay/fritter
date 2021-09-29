import 'package:flutter/material.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';

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
      return SliverToBoxAdapter(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¯\\_(ツ)_/¯', style: TextStyle(
                fontSize: 32
            )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text('Try searching for some users to follow!', style: TextStyle(
                  color: Theme.of(context).hintColor
              )),
            )
          ])
      ));
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