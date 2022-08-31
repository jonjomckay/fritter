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
      await _addToLocationsList(item);
      await prefs.set(optionTrendsLocation, jsonEncode(item.toJson()));
      return item;
    });
  }

  List<TrendLocation> get locations => _locationsList();

  int get locationIndex {
    int index = locations.indexOf(state);
    return index >= 0 ? index : 0;
  }

  List<TrendLocation> _locationsList() {
    var locations = jsonDecode(prefs.get(optionActiveTrendsLocations));
    return [...locations.map((e) => TrendLocation.fromJson(e))];
  }

  Future<void> _addToLocationsList(TrendLocation item) async {
    print('addlocation');
    print(!locations.any((e) => e.woeid == item.woeid));
    if (!locations.any((e) => e.woeid == item.woeid)) {
      locations.add(item);
      await _storeActiveTrendLocations(locations);
    }
  }

  Future<void> removeFromLocationsList(TrendLocation item) async {
    //make sure, worldwide trend won't be removed
    if (item.woeid != 1) {
      int index = locations.indexWhere((element) => element.woeid == item.woeid);
      setTrendLocation(locations[index - 1]);
      locations.removeWhere((element) => element.woeid == item.woeid);
      await _storeActiveTrendLocations(locations);
    }
  }

  Future<void> _storeActiveTrendLocations(List<TrendLocation> locations) async {
    var json = [...locations.map((e) => e.toJson())];
    await prefs.set(optionActiveTrendsLocations, jsonEncode(json));
  }
}

class TrendLocationsModel extends StreamStore<Object, List<TrendLocation>> {
  TrendLocationsModel() : super([]);

  Future<void> loadLocations() async {
    await execute(() async {
      return (await Twitter.getTrendLocations())..sort((a, b) => a.name!.compareTo(b.name!));
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
