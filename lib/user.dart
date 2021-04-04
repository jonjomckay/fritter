import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class UserTile extends StatelessWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;

  const UserTile({Key? key, required this.id, required this.name, required this.screenName, this.imageUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (imageUri == null) {
      image = Container(width: 48, height: 48);
    } else {
      image = CachedNetworkImage(
          imageUrl: imageUri!, // TODO
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error), // TODO: This can error if the profile image has changed... use SWR-like
          width: 48,
          height: 48
      );
    }

    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: image,
      ),
      title: Text(name),
      subtitle: Text('@$screenName'),
      trailing: Container(
        width: 36,
        child: FollowButton(id: id, name: name, screenName: screenName, imageUri: imageUri),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(id: id, username: screenName)));
      },
    );
  }

}