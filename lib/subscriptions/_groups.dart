import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';

class SubscriptionGroups extends StatefulWidget {
  const SubscriptionGroups({Key? key}) : super(key: key);

  @override
  State<SubscriptionGroups> createState() => _SubscriptionGroupsState();
}

class _SubscriptionGroupsState extends State<SubscriptionGroups> {
  void openSubscriptionGroupDialog(String? id, String name, String icon) {
    showDialog(
        context: context,
        builder: (context) {
          return SubscriptionGroupEditDialog(id: id, name: name, icon: icon);
        });
  }

  Widget _createGroupCard(
      String id, String name, String icon, Color? color, int? numberOfMembers, void Function()? onLongPress) {
    var title = numberOfMembers == null ? name : '$name ($numberOfMembers)';

    return Card(
      child: InkWell(
        onTap: () {
          // Open page with the group's feed
          Navigator.pushNamed(context, routeGroup, arguments: GroupScreenArguments(id: id, name: name));
        },
        onLongPress: onLongPress,
        child: Column(
          children: [
            Container(
              color: color != null ? color.withOpacity(0.9) : Theme.of(context).highlightColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Icon(deserializeIconData(icon), size: 16),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: color != null ? color.withOpacity(0.4) : Colors.white10,
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              child: Text(title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupModel>(builder: (context, model, child) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          childAspectRatio: 200 / 125
        ),
        itemCount: model.groups.length + 2,
        itemBuilder: (context, index) {
          var actualIndex = index - 1;
          if (actualIndex == -1) {
            return _createGroupCard('-1', L10n.of(context).all, defaultGroupIcon, null, null, null);
          }

          if (actualIndex < model.groups.length) {
            var e = model.groups[actualIndex];

            return _createGroupCard(e.id, e.name, e.icon, e.color, e.numberOfMembers,
                () => openSubscriptionGroupDialog(e.id, e.name, e.icon));
          }

          return Card(
            child: InkWell(
              onTap: () {
                openSubscriptionGroupDialog(null, '', defaultGroupIcon);
              },
              child: DottedBorder(
                color: Theme.of(context).textTheme.caption!.color!,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, size: 16),
                      const SizedBox(height: 4),
                      Text(
                        L10n.of(context).newTrans,
                        style: const TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class SubscriptionGroupEditDialog extends StatefulWidget {
  final String? id;
  final String name;
  final String icon;

  const SubscriptionGroupEditDialog({Key? key, required this.id, required this.name, required this.icon})
      : super(key: key);

  @override
  State<SubscriptionGroupEditDialog> createState() => _SubscriptionGroupEditDialogState();
}

class _SubscriptionGroupEditDialogState extends State<SubscriptionGroupEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  SubscriptionGroupEdit? _group;

  late String? id;
  late String? name;
  late String icon;
  Color? color;
  Set<String> members = <String>{};

  @override
  void initState() {
    super.initState();

    setState(() {
      icon = widget.icon;
    });

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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(L10n.of(context).no),
              ),
              TextButton(
                onPressed: () async {
                  await context.read<GroupModel>().deleteGroup(id);

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(L10n.of(context).yes),
              ),
            ],
            title: Text(L10n.of(context).are_you_sure),
            content: Text(
              L10n.of(context).are_you_sure_you_want_to_delete_the_subscription_group_name_of_group(name),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var subscriptionsModel = context.read<SubscriptionsModel>();

    var group = _group;
    if (group == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Filter the Material icons to only the baseline ones
    var iconPack = icons.entries.where((value) =>
        !value.key.endsWith('_sharp') &&
        !value.key.endsWith('_rounded') &&
        !value.key.endsWith('_outlined') &&
        !value.key.endsWith('_outline'));

    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (members.isEmpty) {
                members = subscriptionsModel.state.map((e) => e.id).toSet();
              } else {
                members.clear();
              }
            });
          },
          child: Text(L10n.of(context).toggle_all),
        ),
        TextButton(
          onPressed: id == null ? null : () => openDeleteSubscriptionGroupDialog(id!, name!),
          child: Text(L10n.of(context).delete),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(L10n.of(context).cancel),
        ),
        Builder(builder: (context) {
          onPressed() async {
            if (_formKey.currentState!.validate()) {
              await context.read<GroupModel>().saveGroup(id, name!, icon, color, members);

              Navigator.pop(context);
            }
          }

          return TextButton(
            onPressed: onPressed,
            child: Text(L10n.of(context).ok),
          );
        }),
      ],
      content: Form(
        key: _formKey,
        child: SizedBox(
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
                        border: const UnderlineInputBorder(),
                        hintText: L10n.of(context).name,
                      ),
                      onChanged: (value) => setState(() {
                        name = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return L10n.of(context).please_enter_a_name;
                        }

                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.color_lens, color: color),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            var selectedColor = color;

                            return AlertDialog(
                              title: Text(L10n.of(context).pick_a_color),
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
                                  child: Text(L10n.of(context).cancel),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(L10n.of(context).ok),
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
                    icon: Icon(deserializeIconData(icon)),
                    onPressed: () async {
                      var selectedIcon = await FlutterIconPicker.showIconPicker(context,
                          iconPackModes: [IconPack.custom], customIconPack: Map.fromEntries(iconPack),
                          title: Text(L10n.of(context).pick_an_icon), closeChild: Text(L10n.of(context).close),
                          searchHintText: L10n.of(context).search, noResultsText: L10n.of(context).no_results_for);
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
                  itemCount: subscriptionsModel.state.length,
                  itemBuilder: (context, index) {
                    var subscription = subscriptionsModel.state[index];

                    return CheckboxListTile(
                      dense: true,
                      secondary: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: UserAvatar(uri: subscription.profileImageUrlHttps),
                      ),
                      title: Text(subscription.name),
                      subtitle: Text('@${subscription.screenName}'),
                      selected: members.contains(subscription.id),
                      value: members.contains(subscription.id),
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
