import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

ExtendedImage createUserAvatar(String? uri, double size) {
  if (uri == null) {
    return ExtendedImage.memory(Uint8List.fromList([]));
  } else {
    return ExtendedImage.network(
      // TODO: This can error if the profile image has changed... use SWR-like
      uri.replaceAll('normal', '200x200'),
      width: size,
      height: size,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.failed:
            return const Icon(Icons.error);
          default:
            return state.completedWidget;
        }
      },
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String? uri;
  final double size;

  const UserAvatar({Key? key, required this.uri, this.size = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return createUserAvatar(uri, size);
  }
}

class UserTile extends StatelessWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;
  final bool verified;

  const UserTile(
      {Key? key, required this.id, required this.name, required this.screenName, this.imageUri, required this.verified})
      : super(key: key);

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
          if (verified) const SizedBox(width: 6),
          if (verified) const Icon(Icons.verified, size: 14, color: Colors.blue)
        ],
      ),
      subtitle: Text('@$screenName'),
      trailing: SizedBox(
        width: 36,
        child: FollowButton(id: id, name: name, screenName: screenName, imageUri: imageUri, verified: verified),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeProfile, arguments: screenName);
      },
    );
  }
}

class FollowButton extends StatelessWidget {
  final String id;
  final String name;
  final String screenName;
  final String? imageUri;
  final bool verified;

  const FollowButton(
      {Key? key, required this.id, required this.name, required this.screenName, this.imageUri, required this.verified})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupModel, UsersModel>(builder: (context, groupModel, usersModel, child) {
      var followed = usersModel.subscriptionIds.contains(id);

      var icon = followed ? const Icon(Icons.person_remove) : const Icon(Icons.person_add);

      var text = followed ? L10n.of(context).unsubscribe : L10n.of(context).subscribe;

      return PopupMenuButton<String>(
        icon: icon,
        itemBuilder: (context) => [
          PopupMenuItem(child: Text(text), value: 'toggle_subscribe'),
          PopupMenuItem(
            child: Text(L10n.of(context).add_to_group),
            value: 'add_to_group',
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case 'add_to_group':
              showDialog(
                  context: context,
                  builder: (context) {
                    return FutureBuilderWrapper<List<String>>(
                      future: groupModel.listGroupsForUser(id),
                      onError: (error, stackTrace) => FullPageErrorWidget(
                        error: error,
                        stackTrace: stackTrace,
                        prefix: L10n.of(context).unable_to_load_subscription_groups,
                      ),
                      onReady: (existing) {
                        var color = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54;

                        return MultiSelectDialog(
                          searchIcon: Icon(Icons.search, color: color),
                          closeSearchIcon: Icon(Icons.close, color: color),
                          itemsTextStyle: Theme.of(context).textTheme.bodyText1,
                          selectedColor: Theme.of(context).colorScheme.secondary,
                          unselectedColor: color,
                          selectedItemsTextStyle: Theme.of(context).textTheme.bodyText1,
                          items: groupModel.groups.map((e) => MultiSelectItem(e.id, e.name)).toList(),
                          initialValue: existing,
                          onConfirm: (List<String> memberships) async {
                            // If we're not currently following the user, follow them first
                            if (followed == false) {
                              await usersModel.toggleSubscribe(id, screenName, name, imageUri, verified, followed);
                            }

                            // Then add them to all the selected groups
                            await groupModel.saveUserGroupMembership(id, memberships);
                          },
                        );
                      },
                    );
                  });
              break;
            case 'toggle_subscribe':
              await usersModel.toggleSubscribe(id, screenName, name, imageUri, verified, followed);
              break;
          }
        },
      );
    });
  }
}
