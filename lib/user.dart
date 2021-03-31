import 'package:flutter/material.dart';
import 'package:fritter/models.dart';

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: user.username)));
            },
            title: Text(user.fullName,
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(user.username),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.avatar),
            )
          )
        ],
      ),
    );
  }

}