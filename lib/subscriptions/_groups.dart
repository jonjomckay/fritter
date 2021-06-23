import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SubscriptionGroups extends StatefulWidget {
  final ScrollController controller;

  const SubscriptionGroups({Key? key, required this.controller}) : super(key: key);

  @override
  _SubscriptionGroupsState createState() => _SubscriptionGroupsState();
}

class _SubscriptionGroupsState extends State<SubscriptionGroups> {
  late String _orderSubscriptionGroupsByField;
  late bool _orderSubscriptionGroupsAscending;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var prefs = PrefService.of(context);

    setState(() {
      _orderSubscriptionGroupsAscending = prefs.get(OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_ASCENDING) ?? true;
      _orderSubscriptionGroupsByField = prefs.get(OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_FIELD) ?? 'name';
    });
  }

  void _onChangeOrderSubscriptionGroupsBy(String? value) {
    var prefs = PrefService.of(context);

    prefs.set(OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_FIELD, value);

    setState(() {
      this._orderSubscriptionGroupsByField = value ?? 'name';
    });
  }

  void _onToggleOrderSubscriptionGroupsAscending() {
    var prefs = PrefService.of(context);
    var value = !_orderSubscriptionGroupsAscending;

    prefs.set(OPTION_SUBSCRIPTION_GROUPS_ORDER_BY_ASCENDING, value);

    setState(() {
      this._orderSubscriptionGroupsAscending = value;
    });
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
              await model.deleteSubscriptionGroup(id);

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

  void openSubscriptionGroupDialog(String? id, String name) {
    var model = context.read<HomeModel>();

    showDialog(context: context, builder: (context) {
      return FutureBuilderWrapper<SubscriptionGroupEdit>(
        future: model.loadSubscriptionGroupEdit(id),
        onError: (error, stackTrace) => AlertErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to load the subscription group'),
        onReady: (edit) {
          final form = FormGroup({
            'name': FormControl<String>(
                value: name,
                validators: [Validators.required],
                touched: true
            ),
            'subscriptions': FormArray<bool>(
                edit.allSubscriptions
                    .map((e) => FormControl<bool>(value: edit.members.contains(e.id)))
                    .toList(growable: false)
            )
          });

          return ReactiveForm(
              formGroup: form,
              child: AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      var control = form.control('subscriptions') as FormArray<bool?>;

                      var value = control.value;
                      if (value == null || value.isEmpty || value.every((e) => e == false)) {
                        // If no subscriptions are selected, mark them all as selected
                        control.updateValue(edit.allSubscriptions
                            .map((e) => true)
                            .toList(growable: false));
                      } else {
                        // If one or more subscriptions are selected, deselect them all
                        control.updateValue(edit.allSubscriptions
                            .map((e) => false)
                            .toList(growable: false));
                      }
                    },
                    child: Text('Toggle All'),
                  ),
                  TextButton(
                    onPressed: id == null
                        ? null
                        : () => openDeleteSubscriptionGroupDialog(id, name),
                    child: Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      var onPressed = () async {
                        var selectedSubscriptions = (form.control('subscriptions').value as List<bool?>)
                            .asMap().entries
                            .map((e) {
                          var index = e.key;
                          var value = e.value;
                          if (value != null && value == true) {
                            return edit.allSubscriptions[index];
                          }

                          return null;
                        })
                            .where((element) => element != null)
                            .cast<Subscription>()
                            .toList(growable: false);

                        await model.saveSubscriptionGroup(
                            id,
                            form.control('name').value,
                            selectedSubscriptions
                        );

                        Navigator.pop(context);
                      };

                      return TextButton(
                        child: Text('OK'),
                        onPressed: form.valid
                            ? onPressed
                            : null,
                      );
                    },
                  ),
                ],
                content: Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ReactiveTextField(
                        formControlName: 'name',
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Name'
                        ),
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Please enter a name',
                        },
                      ),
                      Expanded(
                        child: SubscriptionCheckboxList(
                          subscriptions: edit.allSubscriptions,
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      );
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
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text('Groups', style: TextStyle(
            fontWeight: FontWeight.bold
        )),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Name'), value: 'name'),
                const PopupMenuItem(child: Text('Date Created'), value: 'created_at'),
              ],
              onSelected: (value) => _onChangeOrderSubscriptionGroupsBy(value),
            ),
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () => _onToggleOrderSubscriptionGroupsAscending(),
            )
          ],
        ),
        children: [
          Consumer<HomeModel>(builder: (context, model, child) {
            return FutureBuilderWrapper<List<SubscriptionGroup>>(
              future: model.listSubscriptionGroups(orderBy: _orderSubscriptionGroupsByField, orderByAscending: _orderSubscriptionGroupsAscending),
              onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to list your subscription groups'),
              onReady: (groups) => Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: GridView.extent(
                    controller: widget.controller,
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 200 / 125,
                    shrinkWrap: true,
                    children: [
                      _createGroupCard(Icons.rss_feed, '-1', 'All', null, null),
                      ...groups.map((e) => _createGroupCard(Icons.rss_feed, e.id, e.name, e.numberOfMembers, () => openSubscriptionGroupDialog(e.id, e.name))),
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
                    ]),
              ),
            );
          })
        ],
      ),
    );
  }
}