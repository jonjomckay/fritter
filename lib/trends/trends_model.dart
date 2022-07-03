import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:pref/pref.dart';

class TrendLocationModel extends StreamStore<Object, TrendLocation> {
  final BasePrefService prefs;

  TrendLocationModel(this.prefs) : super(TrendLocation());

  Future<void> loadLocation() async {
    await execute(() async {
      return TrendLocation.fromJson(jsonDecode(prefs.get(optionTrendsLocation)));
    });
  }

  Future<void> setTrendLocation(TrendLocation item) async {
    await execute(() async {
      prefs.set(optionTrendsLocation, jsonEncode(item.toJson()));
      return item;
    });
  }
}

class TrendLocationsModel extends StreamStore<Object, List<TrendLocation>> {
  TrendLocationsModel() : super([]);

  Future<void> loadLocations() async {
    await execute(() async {
      return (await Twitter.getTrendLocations())
          ..sort((a, b) => a.name!.compareTo(b.name!));
    });
  }
}

class TrendsModel extends StreamStore<Object, List<Trends>> {
  final TrendLocationModel trendLocationModel;

  TrendsModel(this.trendLocationModel) : super([]) {
    // Ensure we reload trends when the saved location changes
    trendLocationModel.observer(onState: (_) async {
      await loadTrends();
    });
  }

  Future<void> loadTrends() async {
    await execute(() async {
      return await Twitter.getTrends(trendLocationModel.state.woeid!);
    });
  }
}
