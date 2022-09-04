import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/subscriptions/_list.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SubscriptionsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const SubscriptionsScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
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
      ),
      body: SubscriptionUsers(scrollController: scrollController),
    );
  }
}
