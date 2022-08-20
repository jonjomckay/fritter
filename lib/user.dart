import 'dart:typed_data';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/subscriptions/users_model.dart';
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
  final User user;

  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: UserAvatar(uri: user.profileImageUrlHttps),
      ),
      title: Row(
        children: [
          Text(user.name!),
          if (user.verified!) const SizedBox(width: 6),
          if (user.verified!) const Icon(Icons.verified, size: 14, color: Colors.blue)
        ],
      ),
      subtitle: Text('@${user.screenName}'),
      trailing: SizedBox(
        width: 36,
        child: FollowButton(user: user),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeProfile, arguments: user.screenName);
      },
    );
  }
}

class FollowButtonSelectGroupDialog extends StatefulWidget {
  final User user;
  final bool followed;

  const FollowButtonSelectGroupDialog({Key? key, required this.user, required this.followed}) : super(key: key);

  @override
  State<FollowButtonSelectGroupDialog> createState() => _FollowButtonSelectGroupDialogState();
}

class _FollowButtonSelectGroupDialogState extends State<FollowButtonSelectGroupDialog> {
  List<String> _groupsForUser = [];

  @override
  void initState() {
    super.initState();

    context.read<GroupsModel>().listGroupsForUser(widget.user.idStr!).then((groups) {
      setState(() {
        _groupsForUser = groups;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var groupModel = context.read<GroupsModel>();
    var subscriptionsModel = context.read<SubscriptionsModel>();

    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54;

    return MultiSelectDialog(
      title: Text(L10n.of(context).select),
      searchHint: L10n.of(context).search,
      confirmText: Text(L10n.of(context).ok),
      cancelText: Text(L10n.of(context).cancel),
      searchIcon: Icon(Icons.search, color: color),
      closeSearchIcon: Icon(Icons.close, color: color),
      itemsTextStyle: Theme.of(context).textTheme.bodyText1,
      selectedColor: Theme.of(context).colorScheme.secondary,
      unselectedColor: color,
      selectedItemsTextStyle: Theme.of(context).textTheme.bodyText1,
      items: groupModel.state.map((e) => MultiSelectItem(e.id, e.name)).toList(),
      initialValue: _groupsForUser,
      onConfirm: (List<String> memberships) async {
        // If we're not currently following the user, follow them first
        if (widget.followed == false) {
          await subscriptionsModel.toggleSubscribe(widget.user, widget.followed);
        }

        // Then add them to all the selected groups
        await groupModel.saveUserGroupMembership(widget.user.idStr!, memberships);
      },
    );
  }
}


class FollowButton extends StatelessWidget {
  final User user;

  const FollowButton({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<SubscriptionsModel>();

    return ScopedBuilder<SubscriptionsModel, Object, List<Subscription>>(
      store: model,
      onState: (_, state) {
        var followed = state.any((element) => element.id == user.idStr);

        var icon = followed ? const Icon(Icons.person_remove) : const Icon(Icons.person_add);
        var text = followed ? L10n.of(context).unsubscribe : L10n.of(context).subscribe;

        return PopupMenuButton<String>(
          icon: icon,
          itemBuilder: (context) => [
            PopupMenuItem(value: 'toggle_subscribe', child: Text(text)),
            PopupMenuItem(
              value: 'add_to_group',
              child: Text(L10n.of(context).add_to_group),
            ),
          ],
          onSelected: (value) async {
            switch (value) {
              case 'add_to_group':
                showDialog(context: context, builder: (_) => FollowButtonSelectGroupDialog(user: user, followed: followed));
                break;
              case 'toggle_subscribe':
                await model.toggleSubscribe(user, followed);
                break;
            }
          },
        );
      },
    );
  }
}
