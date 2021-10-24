import 'dart:convert';
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';

var defaultGroupIcon = '{"pack":"material","key":"rss_feed"}';

IconData? deserializeIconData(String iconData) {
  try {
    var icon = deserializeIcon(jsonDecode(iconData));
    if (icon != null) {
      return icon;
    }
  } catch (e, stackTrace) {
    log('Unable to deserialize icon', error: e, stackTrace: stackTrace);
  }

  // Use this as a default;
  return Icons.rss_feed;
}

class SubscriptionGroups extends StatefulWidget {
  final ScrollController controller;

  const SubscriptionGroups({Key? key, required this.controller}) : super(key: key);

  @override
  _SubscriptionGroupsState createState() => _SubscriptionGroupsState();
}

class _SubscriptionGroupsState extends State<SubscriptionGroups> {
  void openSubscriptionGroupDialog(String? id, String name) {
    showDialog(context: context, builder: (context) {
      return SubscriptionGroupEditDialog(id: id, name: name);
    });
  }

  Widget _createGroupCard(String id, String name, String icon, Color? color, int? numberOfMembers, void Function()? onLongPress) {
    var title = numberOfMembers == null
        ? name
        : '$name ($numberOfMembers)';

    return Card(
      child: InkWell(
        onTap: () {
          // Open page with the group's feed
          Navigator.pushNamed(context, ROUTE_GROUP, arguments: GroupScreenArguments(
              id: id,
              name: name
          ));
        },
        onLongPress: onLongPress,
        child: Column(
          children: [
            Container(
              color: color != null ? color.withOpacity(0.9) : Theme.of(context).highlightColor,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Icon(deserializeIconData(icon), size: 16),
            ),
            Expanded(child: Container(
              alignment: Alignment.center,
              color: color != null ? color.withOpacity(0.4) : Colors.white10,
              width: double.infinity,
              padding: EdgeInsets.all(4),
              child: Text(title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  )
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<GroupModel>();

    return SliverGrid.extent(
      maxCrossAxisExtent: 140,
      childAspectRatio: 200 / 125,
      children: [
        _createGroupCard('-1', 'All', defaultGroupIcon, null, null, null),
        ...model.groups.map((e) => _createGroupCard(e.id, e.name, e.icon, e.color, e.numberOfMembers, () => openSubscriptionGroupDialog(e.id, e.name))),
        Card(
          child: InkWell(
            onTap: () {
              openSubscriptionGroupDialog(null, '');
            },
            child: DottedBorder(
              color: Theme.of(context).textTheme.caption!.color!,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.white10,
                      // width: double.infinity,
                      child: Icon(Icons.add, size: 16),
                    ),
                    SizedBox(height: 4),
                    Text('New', style: TextStyle(
                      fontSize: 11,
                    ))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SubscriptionGroupEditDialog extends StatefulWidget {
  final String? id;
  final String name;

  const SubscriptionGroupEditDialog({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _SubscriptionGroupEditDialogState createState() => _SubscriptionGroupEditDialogState();
}

class _SubscriptionGroupEditDialogState extends State<SubscriptionGroupEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  SubscriptionGroupEdit? _group;

  String? id;
  String? name;
  String? icon;
  Color? color;
  Set<String> members = Set();

  @override
  void initState() {
    super.initState();

    context.read<GroupModel>().loadGroupEdit(widget.id).then((group) => setState(() {
      _group = group;

      id = group.id;
      name = group.name;
      icon = group.icon;
      color = group.color;
      members = group.members;
    }));
  }

  void openDeleteSubscriptionGroupDialog(String id, String name) {
    var model = context.read<GroupModel>();

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await model.deleteGroup(id);

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
        title: Text('Are you sure?'),
        content: Text('Are you sure you want to delete the subscription group $name?'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var groupModel = context.read<GroupModel>();
    var usersModel = context.read<UsersModel>();

    var group = _group;
    if (group == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Filter the Material icons to only the baseline ones
    var iconPack = icons.entries
        .where((value) => !value.key.endsWith('_sharp') && !value.key.endsWith('_rounded') && !value.key.endsWith('_outlined') && !value.key.endsWith('_outline'));

    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (members.isEmpty) {
                members = usersModel.subscriptions.map((e) => e.id).toSet();
              } else {
                members.clear();
              }
            });
          },
          child: Text('Toggle All'),
        ),
        TextButton(
          onPressed: id == null
              ? null
              : () => openDeleteSubscriptionGroupDialog(id!, name!),
          child: Text('Delete'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        Builder(builder: (context) {
          var onPressed = () async {
            if (_formKey.currentState!.validate()) {
              await groupModel.saveGroup(id, name!, icon, color, members);

              Navigator.pop(context);
            }
          };

          return TextButton(
            child: Text('OK'),
            onPressed: onPressed,
          );
        }),
      ],
      content: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: group.name,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Name'
                      ),
                      onChanged: (value) => setState(() {
                        name = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }

                        return null;
                      },
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.color_lens, color: color),
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        var selectedColor = color;

                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: MaterialPicker(
                              pickerColor: color ?? Colors.grey,
                              onColorChanged: (value) => setState(() {
                                selectedColor = value;
                              }),
                              enableLabel: true,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                setState(() {
                                  color = selectedColor;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(icon == null ? Icons.rss_feed : deserializeIconData(icon!)),
                    onPressed: () async {
                      var selectedIcon = await FlutterIconPicker.showIconPicker(context, iconPackMode: IconPack.custom, customIconPack: Map.fromEntries(iconPack));
                      if (selectedIcon != null) {
                        setState(() {
                          icon = jsonEncode(serializeIcon(selectedIcon));
                        });
                      }
                    },
                  )
                ],
              ),

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: usersModel.subscriptions.length,
                  itemBuilder: (context, index) {
                    var subscription = usersModel.subscriptions[index];

                    return CheckboxListTile(
                      dense: true,
                      secondary: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: UserAvatar(uri: subscription.profileImageUrlHttps),
                      ),
                      title: Text(subscription.name),
                      subtitle: Text('@${subscription.screenName}'),
                      selected: group.members.contains(subscription.id),
                      value: group.members.contains(subscription.id),
                      onChanged: (v) => setState(() {
                        if (v == null || v == false) {
                          members.remove(subscription.id);
                        } else {
                          members.add(subscription.id);
                        }
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
