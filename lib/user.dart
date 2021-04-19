import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database/repository.dart';
import 'profile.dart';

class UserTile extends StatelessWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;

  const UserTile({Key? key, required this.id, required this.name, required this.screenName, this.imageUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUri = this.imageUri;

    var image = imageUri == null
        ? Container(width: 48, height: 48)
        : CachedNetworkImage(
            imageUrl: imageUri.replaceAll('normal', '200x200'),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error), // TODO: This can error if the profile image has changed... use SWR-like
            width: 48,
            height: 48
          );

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

class FollowButton extends StatefulWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;

  const FollowButton({Key? key, required this.id, required this.name, required this.screenName, this.imageUri}) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool? _followed;

  @override
  void initState() {
    super.initState();

    fetchFollowed();
  }

  Future fetchFollowed() {
    return isFollowed(int.parse(widget.id)).then((value) => setState(() {
      this._followed = value;
    }));
  }

  Future<bool> isFollowed(int id) async {
    Database database = await Repository.readOnly();

    var result = await database.rawQuery('SELECT EXISTS (SELECT 1 FROM $TABLE_SUBSCRIPTION WHERE id = ?)', [id]);
    if (result.isEmpty) {
      return false;
    }

    return result.first.values.first == 1;
  }

  @override
  Widget build(BuildContext context) {
    var id = int.parse(widget.id);

    var followed = _followed;
    if (followed == null) {
      return Center(child: CircularProgressIndicator());
    }

    var icon = followed
        ? Icon(Icons.person_remove)
        : Icon(Icons.person_add);

    return IconButton(icon: icon, onPressed: () async {
      Database database = await Repository.writable();

      if (followed) {
        await database.delete(TABLE_SUBSCRIPTION, where: 'id = ?', whereArgs: [id]);
      } else {
        await database.insert(TABLE_SUBSCRIPTION, {
          'id': id,
          'screen_name': widget.screenName,
          'name': widget.name,
          'profile_image_url_https': widget.imageUri
        });
      }

      await fetchFollowed();
    });
  }
}
