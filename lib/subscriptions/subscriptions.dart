import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/subscriptions/_groups.dart';
import 'package:fritter/subscriptions/_list.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:provider/provider.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  final _scrollController = ScrollController();

  bool _isLoading = false;

  Future _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<UsersModel>().refreshSubscriptionData();
    } catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to refresh the subscriptions. The error was $e'),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Consumer2<GroupModel, UsersModel>(builder: (context, groupModel, usersModel, child) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(pinned:true, title: Text('Groups'), actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Name'), value: 'name'),
                const PopupMenuItem(child: Text('Date Created'), value: 'created_at'),
              ],
              onSelected: (value) => groupModel.changeOrderSubscriptionGroupsBy(value),
            ),
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () => groupModel.toggleOrderSubscriptionGroupsAscending(),
            )
          ]),
          SubscriptionGroups(controller: _scrollController),

          SliverAppBar(pinned: true, title: Text('Subscriptions'), actions: [
            IconButton(
              icon: Icon(Icons.import_export),
              onPressed: () => Navigator.pushNamed(context, ROUTE_SUBSCRIPTIONS_IMPORT),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _onRefresh(),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Name'), value: 'name'),
                const PopupMenuItem(child: Text('Username'), value: 'screen_name'),
                const PopupMenuItem(child: Text('Date Subscribed'), value: 'created_at'),
              ],
              onSelected: (value) => usersModel.changeOrderSubscriptionsBy(value),
            ),
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () => usersModel.toggleOrderSubscriptionsAscending(),
            )
          ]),
          SubscriptionUsers(),
        ],
      );
    });
  }
}
