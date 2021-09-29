import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class TrendsSettings extends StatefulWidget {
  const TrendsSettings({Key? key}) : super(key: key);

  @override
  _TrendsSettingsState createState() => _TrendsSettingsState();
}

class _TrendsSettingsState extends State<TrendsSettings> {
  late Future<List<TrendLocation>> _future;

  @override
  void initState() {
    super.initState();

    fetchTrendLocations();
  }

  void fetchTrendLocations() {
    setState(() {
      _future = Twitter.getTrendLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context);
    var model = context.read<HomeModel>();

    return AlertDialog(
      content: FutureBuilderWrapper<List<TrendLocation>>(
          future: _future,
          onError: (error, stackTrace) => FullPageErrorWidget(
              error: error,
              stackTrace: stackTrace,
              prefix: 'Unable to find the available trend locations.',
              onRetry: () => fetchTrendLocations()
          ),
          onReady: (trends) {
            trends.sort((a, b) => a.name!.compareTo(b.name!));

            var place = TrendLocation.fromJson(jsonDecode(prefs.get(OPTION_TRENDS_LOCATION)));

            var countries = trends
                .sorted((a, b) => a.name!.compareTo(b.name!))
                .groupBy((e) => e.country);

            var names = countries.keys
                .sorted((a, b) => a!.compareTo(b!))
                .toList();

            var _createLocationTile = (TrendLocation item) {
              var subtitle = item.parentid == 1
                  ? Text('Country')
                  : null;

              return RadioListTile<int?>(
                  title: Text(item.name!),
                  subtitle: subtitle,
                  value: item.woeid,
                  selected: place.woeid == item.woeid,
                  groupValue: place.woeid,
                  onChanged: (value) async {
                    await model.setTrendLocation(item);

                    Navigator.pop(context);
                  }
              );
            };

            return Container(
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    var name = names[index]!;
                    if (name == '') {
                      // If there's no country name, assume it's "Worldwide"
                      return _createLocationTile(TrendLocation.fromJson({
                        'name': 'Worldwide',
                        'woeid': 1
                      }));
                    }

                    return ExpansionTile(
                      title: Text(name),
                      children: [
                        ...countries[name]!.map((item) => _createLocationTile(item))
                      ],
                    );
                  },
                )
            );
          }
      ),
    );
  }
}