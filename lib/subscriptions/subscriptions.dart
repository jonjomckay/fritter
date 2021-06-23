import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/subscriptions/_groups.dart';
import 'package:fritter/subscriptions/_list.dart';
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
      await context.read<HomeModel>().refreshSubscriptionUsers();
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

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          SubscriptionGroups(controller: _scrollController),
          SubscriptionUsers(controller: _scrollController, onRefresh: () => _onRefresh()),
        ],
      ),
    );
  }
}
