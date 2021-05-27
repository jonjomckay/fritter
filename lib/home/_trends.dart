import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:intl/intl.dart';
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
                    await model.setTrendLocation(prefs, item);

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

class TrendsList extends StatefulWidget {
  final TrendLocation place;

  const TrendsList({Key? key, required this.place}) : super(key: key);

  @override
  _TrendsListState createState() => _TrendsListState();
}

class _TrendsListState extends State<TrendsList> {
  late Future<List<Trends>> _future;

  @override
  void initState() {
    super.initState();

    fetchTrends();
  }

  void fetchTrends() {
    setState(() {
      _future = context.read<HomeModel>().loadTrends(widget.place.woeid!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWrapper<List<Trends>>(
      future: _future,
      onError: (error, stackTrace) => FullPageErrorWidget(
        error: error,
        stackTrace: stackTrace,
        prefix: 'Unable to load the trends for ${widget.place.name}',
        onRetry: () => fetchTrends(),
      ),
      onReady: (data) {
        var trends = data[0].trends;
        if (trends == null) {
          return Text('There were no trends returned. This is unexpected! Please report as a bug, if possible.');
        }

        var numberFormat = NumberFormat.compact();

        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: trends.length,
          itemBuilder: (context, index) {
            var trend = trends[index];

            return ListTile(
              dense: true,
              leading: Text('${++index}'),
              title: Text('${trend.name!}'),
              subtitle: trend.tweetVolume == null
                  ? null
                  : Text('${numberFormat.format(trend.tweetVolume)} tweets'),
              onTap: () async {
                await showSearch(
                    context: context,
                    delegate: TweetSearchDelegate(
                        initialTab: 1
                    ),
                    query: Uri.decodeQueryComponent(trend.query!)
                );
              },
            );
          },
        );
      },
    );
  }
}


class TrendsContent extends StatefulWidget {
  @override
  _TrendsContentState createState() => _TrendsContentState();
}

class _TrendsContentState extends State<TrendsContent> {
  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context);

    return SingleChildScrollView(
      child: StreamBuilder<String>(
        stream: prefs.stream(OPTION_TRENDS_LOCATION),
        builder: (context, snapshot) {
          var error = snapshot.error;
          if (error != null) {
            return FullPageErrorWidget(error: error, stackTrace: snapshot.stackTrace, prefix: 'Unable to stream the trend location preference');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.active:
              var place = TrendLocation.fromJson(jsonDecode(snapshot.data!));

              return Column(
                children: [
                  Container(
                    child: ListTile(
                        title: Text('${place.name} trends', style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () async => showDialog(context: context, builder: (context) {
                                return TrendsSettings();
                              }),
                            )
                          ],
                        )
                    ),
                  ),
                  TrendsList(place: place),
                ],
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}