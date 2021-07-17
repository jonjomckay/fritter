import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class SubscriptionUsers extends StatefulWidget {
  final ScrollController controller;
  final Function onRefresh;

  const SubscriptionUsers({Key? key, required this.controller, required this.onRefresh}) : super(key: key);

  @override
  _SubscriptionUsersState createState() => _SubscriptionUsersState();
}

class _SubscriptionUsersState extends State<SubscriptionUsers> {
  late String _orderSubscriptionsByField;
  late bool _orderSubscriptionsAscending;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var prefs = PrefService.of(context);

    setState(() {
      _orderSubscriptionsAscending = prefs.get(OPTION_SUBSCRIPTION_ORDER_BY_ASCENDING) ?? true;
      _orderSubscriptionsByField = prefs.get(OPTION_SUBSCRIPTION_ORDER_BY_FIELD) ?? 'name';
    });
  }

  void _onChangeOrderSubscriptionsBy(String? value) {
    var prefs = PrefService.of(context);

    prefs.set(OPTION_SUBSCRIPTION_ORDER_BY_FIELD, value);

    setState(() {
      this._orderSubscriptionsByField = value ?? 'name';
    });
  }

  void _onToggleOrderSubscriptionsAscending() {
    var prefs = PrefService.of(context);
    var value = !_orderSubscriptionsAscending;

    prefs.set(OPTION_SUBSCRIPTION_ORDER_BY_ASCENDING, value);

    setState(() {
      this._orderSubscriptionsAscending = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text('Subscriptions', style: TextStyle(
            fontWeight: FontWeight.bold
        )),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.import_export),
              onPressed: () => Navigator.pushNamed(context, ROUTE_SUBSCRIPTIONS_IMPORT),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => widget.onRefresh(),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Name'), value: 'name'),
                const PopupMenuItem(child: Text('Username'), value: 'screen_name'),
                const PopupMenuItem(child: Text('Date Subscribed'), value: 'created_at'),
              ],
              onSelected: (value) => _onChangeOrderSubscriptionsBy(value),
            ),
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () => _onToggleOrderSubscriptionsAscending(),
            )
          ],
        ),
        children: [
          FutureBuilderWrapper<List<Subscription>>(
            future: model.listSubscriptions(orderBy: _orderSubscriptionsByField, orderByAscending: _orderSubscriptionsAscending),
            onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to list your subscriptions'),
            onReady: (data) {
              if (data.isEmpty) {
                return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¯\\_(ツ)_/¯', style: TextStyle(
                          fontSize: 32
                      )),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Try searching for some users to follow!', style: TextStyle(
                            color: Theme.of(context).hintColor
                        )),
                      )
                    ])
                );
              }

              return ListView.builder(
                controller: widget.controller,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var user = data[index];

                  return UserTile(
                    id: user.id.toString(),
                    name: user.name,
                    screenName: user.screenName,
                    imageUri: user.profileImageUrlHttps,
                    verified: user.verified,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}