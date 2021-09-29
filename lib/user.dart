import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database/repository.dart';

class UserAvatar extends StatelessWidget {
  final String? uri;

  const UserAvatar({Key? key, required this.uri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uri = this.uri;
    if (uri == null) {
      return Container(width: 48, height: 48);
    } else {
      return ExtendedImage.network(
        // TODO: This can error if the profile image has changed... use SWR-like
        uri.replaceAll('normal', '200x200'),
        width: 48,
        height: 48,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.failed:
              return Icon(Icons.error);
            default:
              return state.completedWidget;
          }
        },
      );
    }
  }
}


class UserTile extends StatelessWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;
  final bool verified;

  const UserTile({Key? key, required this.id, required this.name, required this.screenName, this.imageUri, required this.verified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: UserAvatar(uri: imageUri),
      ),
      title: Row(
        children: [
          Text(name),
          if (verified)
            SizedBox(width: 6),
          if (verified)
            Icon(Icons.verified, size: 14, color: Colors.blue)
        ],
      ),
      subtitle: Text('@$screenName'),
      trailing: Container(
        width: 36,
        child: FollowButton(id: id, name: name, screenName: screenName, imageUri: imageUri, verified: verified),
      ),
      onTap: () {
        Navigator.pushNamed(context, ROUTE_PROFILE, arguments: screenName);
      },
    );
  }

}

// TODO: This is a very stateful widget. It can probably be extracted out into a
// model so this widget can become a little simpler.
class FollowButton extends StatefulWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;
  final bool verified;

  const FollowButton({Key? key, required this.id, required this.name, required this.screenName, this.imageUri, required this.verified}) : super(key: key);

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
    return isFollowed(int.parse(widget.id)).then((value) {
      if (this.mounted) {
        setState(() {
          this._followed = value;
        });
      }
    });
  }

  Future<bool> isFollowed(int id) async {
    Database database = await Repository.readOnly();

    var result = await database.rawQuery('SELECT EXISTS (SELECT 1 FROM $TABLE_SUBSCRIPTION WHERE id = ?)', [id]);
    if (result.isEmpty) {
      return false;
    }

    return result.first.values.first == 1;
  }

  Future<List<String>> listGroupsForUser(int id) async {
    Database database = await Repository.readOnly();

    return (await database.query(TABLE_SUBSCRIPTION_GROUP_MEMBER, columns: ['group_id'], where: 'profile_id = ?', whereArgs: [id]))
      .map((e) => e['group_id'] as String)
      .toList(growable: false);
  }

  Future toggleSubscribe(int id, bool currentlyFollowed) async {
    Database database = await Repository.writable();

    if (currentlyFollowed) {
      await database.delete(TABLE_SUBSCRIPTION, where: 'id = ?', whereArgs: [id]);
      await database.delete(TABLE_SUBSCRIPTION_GROUP_MEMBER, where: 'profile_id = ?', whereArgs: [id]);
    } else {
      await database.insert(TABLE_SUBSCRIPTION, {
        'id': id,
        'screen_name': widget.screenName,
        'name': widget.name,
        'profile_image_url_https': widget.imageUri,
        'verified': widget.verified
      });
    }

    await fetchFollowed();
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

    var text = followed
        ? 'Unsubscribe'
        : 'Subscribe';

    var model = context.read<HomeModel>();

    return PopupMenuButton<String>(
      icon: icon,
      itemBuilder: (context) => [
        PopupMenuItem(child: Text(text), value: 'toggle_subscribe'),
        PopupMenuItem(child: Text('Add to group'), value: 'add_to_group'),
      ],
      onSelected: (value) async {
        switch (value) {
          case 'add_to_group':
            showDialog(context: context, builder: (context) {
              // TODO: Add types
              return FutureBuilderWrapper<List<dynamic>>(
                future: listGroupsForUser(id),
                onError: (error, stackTrace) => FullPageErrorWidget(
                  error: error,
                  stackTrace: stackTrace,
                  prefix: 'Unable to load subscription groups',
                ),
                onReady: (data) {
                  var existing = data as List<String>;

                  var color = Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black54;

                  return MultiSelectDialog(
                    searchIcon: Icon(Icons.search, color: color),
                    closeSearchIcon: Icon(Icons.close, color: color),
                    itemsTextStyle: Theme.of(context).textTheme.bodyText1,
                    selectedColor: Theme.of(context).accentColor,
                    unselectedColor: color,
                    selectedItemsTextStyle: Theme.of(context).textTheme.bodyText1,
                    items: model.groups.map((e) => MultiSelectItem(e.id, e.name)).toList(),
                    initialValue: existing,
                    onConfirm: (List<String> memberships) async {
                      // If we're not currently following the user, follow them first
                      if (followed == false) {
                        await toggleSubscribe(id, followed);
                      }

                      // Then add them to all the selected groups
                      // TODO: Test this still works
                      await context.read<HomeModel>()
                          .saveUserGroupMembership(id, memberships);
                    },
                  );
                },
              );
            });
            break;
          case 'toggle_subscribe':
            await toggleSubscribe(id, followed);
            break;
        }
      },
    );
  }
}
