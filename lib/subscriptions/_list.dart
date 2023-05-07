import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

class SubscriptionUsers extends StatefulWidget {
  const SubscriptionUsers({Key? key}) : super(key: key);

  @override
  State<SubscriptionUsers> createState() => _SubscriptionUsersState();
}

class _SubscriptionUsersState extends State<SubscriptionUsers> {
  @override
  Widget build(BuildContext context) {
    var model = context.read<SubscriptionsModel>();

    return ScopedBuilder<SubscriptionsModel, Object, List<Subscription>>.transition(
      store: model,
      onLoading: (_) => const Center(child: CircularProgressIndicator()),
      onError: (_, e) => FullPageErrorWidget(error: e, stackTrace: null, prefix: L10n.of(context).unable_to_refresh_the_subscriptions),
      onState: (_, state) {
        if (state.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('¯\\_(ツ)_/¯', style: TextStyle(fontSize: 32)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(L10n.of(context).no_subscriptions_try_searching_or_importing_some,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      child: Text(L10n.of(context).import_from_twitter),
                      onPressed: () => Navigator.pushNamed(context, routeSubscriptionsImport),
                    ),
                  )
                ]));
        }

        return SubscriptionUsersList(subscriptions: state);
      },
    );
  }
}

class SubscriptionUsersList extends StatelessWidget {
  final List<Subscription> subscriptions;

  const SubscriptionUsersList({Key? key, required this.subscriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: subscriptions.length,
      itemBuilder: (context, i) {
        var user = subscriptions[i];
        if (user is UserSubscription) {
          return UserTile(user: user);
        }

        return ListTile(
          dense: true,
          leading: const SizedBox(width: 48, child: Icon(Icons.search)),
          title: Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(L10n.current.search_term),
          trailing: SizedBox(
            width: 36,
            child: FollowButton(user: user),
          ),
          onTap: () => showSnackBar(context, icon: '🙈', message: L10n.current.functionality_unsupported),
        );
      },
    );
  }
}
