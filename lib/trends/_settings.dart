import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

class TrendsSettings extends StatefulWidget {
  const TrendsSettings({Key? key}) : super(key: key);

  @override
  State<TrendsSettings> createState() => _TrendsSettingsState();
}

class _TrendsSettingsState extends State<TrendsSettings> {
  @override
  void initState() {
    super.initState();

    context.read<TrendLocationsModel>().loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context);
    var model = context.read<TrendLocationsModel>();

    return AlertDialog(
      content: ScopedBuilder<TrendLocationsModel, Object, List<TrendLocation>>.transition(
        store: model,
        onError: (_, e) => FullPageErrorWidget(
          error: e,
          stackTrace: null,
          prefix: L10n.of(context).unable_to_find_the_available_trend_locations,
          onRetry: () => model.loadLocations(),
        ),
        onLoading: (_) => const Center(child: CircularProgressIndicator()),
        onState: (_, state) {
          var place = UserTrendLocations.fromJson(jsonDecode(prefs.get(optionUserTrendsLocations))).active;

          var countries = state.sorted((a, b) => a.name!.compareTo(b.name!)).groupBy((e) => e.country);

          var names = countries.keys.sorted((a, b) => a!.compareTo(b!)).toList();

          createLocationTile(TrendLocation item) {
            var subtitle = item.parentid == 1 ? Text(L10n.of(context).country) : null;

            return RadioListTile<int?>(
                title: Text(item.name!),
                subtitle: subtitle,
                value: item.woeid,
                selected: place.woeid == item.woeid,
                groupValue: place.woeid,
                onChanged: (value) async {
                  await context.read<UserTrendLocationModel>().set(item);
                  Navigator.pop(context);
                });
          }

          return SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                var name = names[index]!;
                if (name == '') {
                  // If there's no country name, assume it's "Worldwide"
                  return createLocationTile(TrendLocation.fromJson({'name': 'Worldwide', 'woeid': 1}));
                }

                return ExpansionTile(
                  title: Text(name),
                  children: [...countries[name]!.map((item) => createLocationTile(item))],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
