import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/subscriptions/_groups.dart';
import 'package:fritter/subscriptions/_list.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            L10n.of(context).unable_to_refresh_the_subscriptions_the_error_was_e(e),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer2<GroupModel, UsersModel>(builder: (context, groupModel, usersModel, child) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(pinned: true, title: Text(L10n.of(context).groups), actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(L10n.of(context).name),
                  value: 'name',
                ),
                PopupMenuItem(
                  child: Text(L10n.of(context).date_created),
                  value: 'created_at',
                ),
              ],
              onSelected: (value) => groupModel.changeOrderSubscriptionGroupsBy(value),
            ),
            IconButton(
              icon: const Icon(Icons.sort_by_alpha),
              onPressed: () => groupModel.toggleOrderSubscriptionGroupsAscending(),
            )
          ]),
          SubscriptionGroups(controller: _scrollController),
          SliverAppBar(pinned: true, title: Text(L10n.of(context).subscriptions), actions: [
            IconButton(
              icon: const Icon(Icons.import_export),
              onPressed: () => Navigator.pushNamed(context, routeSubscriptionsImport),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _onRefresh(),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(L10n.of(context).name),
                  value: 'name',
                ),
                PopupMenuItem(
                  child: Text(L10n.of(context).username),
                  value: 'screen_name',
                ),
                PopupMenuItem(
                  child: Text(L10n.of(context).date_subscribed),
                  value: 'created_at',
                ),
              ],
              onSelected: (value) => usersModel.changeOrderSubscriptionsBy(value),
            ),
            IconButton(
              icon: const Icon(Icons.sort_by_alpha),
              onPressed: () => usersModel.toggleOrderSubscriptionsAscending(),
            )
          ]),
          const SubscriptionUsers(),
        ],
      );
    });
  }
}
