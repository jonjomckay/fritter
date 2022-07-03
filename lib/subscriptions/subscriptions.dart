import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/subscriptions/_list.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:provider/provider.dart';

class SubscriptionsScreen extends StatelessWidget with AppBarMixin {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: Text(L10n.current.subscriptions),
      actions: [
        IconButton(
          icon: const Icon(Icons.import_export),
          onPressed: () => Navigator.pushNamed(context, routeSubscriptionsImport),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<SubscriptionsModel>().refreshSubscriptionData(),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'name',
              child: Text(L10n.of(context).name),
            ),
            PopupMenuItem(
              value: 'screen_name',
              child: Text(L10n.of(context).username),
            ),
            PopupMenuItem(
              value: 'created_at',
              child: Text(L10n.of(context).date_subscribed),
            ),
          ],
          onSelected: (value) => context.read<SubscriptionsModel>().changeOrderSubscriptionsBy(value),
        ),
        IconButton(
          icon: const Icon(Icons.sort_by_alpha),
          onPressed: () => context.read<SubscriptionsModel>().toggleOrderSubscriptionsAscending(),
        ),
        ...createCommonAppBarActions(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Rename
    return const SubscriptionUsers();
  }
}
