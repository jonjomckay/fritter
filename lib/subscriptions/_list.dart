import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home_model.dart';
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
    var model = context.read<HomeModel>();
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

    return DiffUtilSliverList<Subscription>(
      items: model.subscriptions,
      builder: (context, user) => UserTile(
        id: user.id.toString(),
        name: user.name,
        screenName: user.screenName,
        imageUri: user.profileImageUrlHttps,
        verified: user.verified,
      ),
      insertAnimationBuilder: (context, animation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      removeAnimationBuilder: (context, animation, child) => SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
    );
  }
}