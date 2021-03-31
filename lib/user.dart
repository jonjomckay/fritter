import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: user.screenName!)));
            },
            title: Text(user.name!,
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(user.screenName!),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.profileImageUrlHttps!),
            )
          )
        ],
      ),
    );
  }

}