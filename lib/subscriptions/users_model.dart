import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/group/group_model.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';

class SubscriptionsModel extends StreamStore<Object, List<Subscription>> {
  static final log = Logger('SubscriptionsModel');

  final BasePrefService prefs;
  final GroupModel groupModel;

  SubscriptionsModel(this.prefs, this.groupModel) : super([]);

  bool get orderSubscriptionsAscending => prefs.get(optionSubscriptionOrderByAscending);
  String get orderSubscriptions => prefs.get(optionSubscriptionOrderByField);

  Future<void> reloadSubscriptions() async {
    log.info('Listing subscriptions');

    await execute(() async {
      var database = await Repository.readOnly();

      var orderByDirection = orderSubscriptionsAscending ? 'COLLATE NOCASE ASC' : 'COLLATE NOCASE DESC';

      return (await database.query(tableSubscription, orderBy: '$orderSubscriptions $orderByDirection'))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);
    });
  }

  Future<void> refreshSubscriptionData() async {
    log.info('Refreshing subscription data');
    
    await execute(() async {
      var database = await Repository.writable();

      var ids = (await database.query(tableSubscription, columns: ['id'])).map((e) => e['id'] as String).toList();

      var users = await Twitter.getUsers(ids);

      var batch = database.batch();
      for (var user in users) {
        batch.update(
            tableSubscription,
            {
              'screen_name': user.screenName,
              'name': user.name,
              'profile_image_url_https': user.profileImageUrlHttps,
              'verified': (user.verified ?? false) ? 1 : 0
            },
            where: 'id = ?',
            whereArgs: [user.idStr]);
      }

      await batch.commit();
      await reloadSubscriptions();
      
      return state;
    });
  }

  Future<void> toggleSubscribe(
      String id, String screenName, String name, String? imageUri, bool verified, bool currentlyFollowed) async {
    var database = await Repository.writable();

    await execute(() async {
      if (currentlyFollowed) {
        await database.delete(tableSubscription, where: 'id = ?', whereArgs: [id]);
        await database.delete(tableSubscriptionGroupMember, where: 'profile_id = ?', whereArgs: [id]);

        state.removeWhere((e) => e.id == id);
      } else {
        var subscription = Subscription.fromMap({
          'id': id,
          'screen_name': screenName,
          'name': name,
          'profile_image_url_https': imageUri,
          'verified': verified
        });

        database.insert(tableSubscription, subscription.toMap());
        state.add(subscription);
      }

      return state;
    });

    await groupModel.reloadGroups();
  }

  void changeOrderSubscriptionsBy(String? value) async {
    await prefs.set(optionSubscriptionOrderByField, value ?? 'name');
    await reloadSubscriptions();
  }

  void toggleOrderSubscriptionsAscending() async {
    await prefs.set(optionSubscriptionOrderByAscending, !orderSubscriptionsAscending);
    await reloadSubscriptions();
  }
}
