import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';

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

  Widget _createGroupCard(IconData icon, String id, String name, int? numberOfMembers, void Function()? onLongPress) {
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
              color: Colors.white10,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Icon(icon, size: 16),
            ),
            Expanded(child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).highlightColor,
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
    var model = context.read<HomeModel>();

    return SliverGrid.extent(
      maxCrossAxisExtent: 140,
      childAspectRatio: 200 / 125,
      children: [
        _createGroupCard(Icons.rss_feed, '-1', 'All', null, null),
        ...model.groups.map((e) => _createGroupCard(Icons.rss_feed, e.id, e.name, e.numberOfMembers, () => openSubscriptionGroupDialog(e.id, e.name))),
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
  Set<String> members = Set();

  @override
  void initState() {
    super.initState();

    context.read<HomeModel>().loadGroupEdit(widget.id).then((group) => setState(() {
      _group = group;

      id = group.id;
      name = group.name;
      members = group.members;
    }));
  }

  void openDeleteSubscriptionGroupDialog(String id, String name) {
    var model = context.read<HomeModel>();

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
    var model = context.read<HomeModel>();

    var group = _group;
    if (group == null) {
      return Center(child: CircularProgressIndicator());
    }

    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (members.isEmpty) {
                members = group.allSubscriptions.map((e) => e.id).toSet();
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
              await model.saveGroup(
                  id,
                  name!,
                  members
              );

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
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
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

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.subscriptions.length,
                  itemBuilder: (context, index) {
                    var subscription = model.subscriptions[index];

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
