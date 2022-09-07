import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:pref/pref.dart';

class TrendLocationsModel extends StreamStore<Object, List<TrendLocation>> {
  TrendLocationsModel() : super([]);

  Future<void> loadLocations() async {
    await execute(() async {
      return (await Twitter.getTrendLocations())..sort((a, b) => a.name!.compareTo(b.name!));
    });
  }
}

class TrendsModel extends StreamStore<Object, List<Trends>> {
  final UserTrendLocationModel userTrendLocationModel;

  TrendsModel(this.userTrendLocationModel) : super([]) {
    // Ensure we reload trends when the saved location changes
    userTrendLocationModel.observer(onState: (_) async {
      await loadTrends();
    });
  }

  Future<void> loadTrends() async {
    await execute(() async {
      return await Twitter.getTrends(userTrendLocationModel.state.active.woeid!);
    });
  }
}

class UserTrendLocationModel extends StreamStore<Object, UserTrendLocations> {
  final BasePrefService _prefs;

  UserTrendLocationModel(this._prefs) : super(UserTrendLocations());

  Future<void> loadTrendLocation() async {
    await execute(() async {
      var locations = jsonDecode(_prefs.get(optionUserTrendsLocations));
      return UserTrendLocations.fromJson(locations);
    });
  }

  Future<void> save(UserTrendLocations item) async {
    await execute(() async {
      await _prefs.set(optionUserTrendsLocations, item.toJson());
      return item;
    });
  }

  Future<void> set(TrendLocation item) async {
    state.addLocation(item);
    await save(state);
  }

  Future<void> remove(TrendLocation location) async {
    await execute(() async {
      state.removeLocation(location);
      await save(state);
      return state;
    });
  }

  Future<void> change(TrendLocation location) async {
    await execute(() async {
      state.active = location;
      await save(state);
      return state;
    });
  }
}

class UserTrendLocations {
  static final TrendLocation _default = TrendLocation.fromJson({'name': 'Worldwide', 'woeid': 1});

  TrendLocation active = _default;
  List<TrendLocation> locations = [_default];

  UserTrendLocations();

  UserTrendLocations.fromJson(Map<String, dynamic> userTrendLocations) {
    active = TrendLocation.fromJson(userTrendLocations['active']);
    locations = [...userTrendLocations['locations'].map((e) => TrendLocation.fromJson(e))];
  }

  int get indexOfActive {
    int index = locations.indexWhere((e) => e.woeid == active.woeid);
    return index >= 0 ? index : 0;
  }

  void addLocation(TrendLocation location) {
    active = location;
    if (!locations.any((e) => e.woeid == location.woeid)) {
      locations.add(location);
    }
  }

  void removeLocation(TrendLocation location) {
    int index = locations.indexWhere((e) => e.woeid == location.woeid);

    //make sure list is not empty and 'worldwide' won't get removed
    if (index > 0 && locations[index].woeid != 1) {
      active = locations[index - 1];
      locations.removeAt(index);
    }
  }

  String toJson() {
    return jsonEncode(
      {
        'active': active.toJson(),
        'locations': locations.toJson(),
      },
    );
  }
}

extension Json on List<TrendLocation> {
  List<dynamic> toJson() {
    return [...map((e) => e.toJson())];
  }
}
