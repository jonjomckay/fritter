import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
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
  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context);
    var model = context.read<HomeModel>();

    return FutureBuilderWrapper<List<TrendLocation>>(
        future: Twitter.getTrendLocations(),
        onError: (error, stackTrace) {
          return Center(
            child: Text('$error'),
          );
        },
        onReady: (data) {
          if (data == null) {
            return Text('There were no trend locations returned. This is unexpected! Please report as a bug, if possible.');
          }

          data.sort((a, b) => a.name!.compareTo(b.name!));

          var place = TrendLocation.fromJson(jsonDecode(prefs.get(OPTION_TRENDS_LOCATION)));

          var countries = data
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

          return AlertDialog(
            content: Container(
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
            ),
          );
        }
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
    var model = context.read<HomeModel>();
    var prefs = PrefService.of(context);

    return SingleChildScrollView(
      child: StreamBuilder<String>(
        stream: prefs.stream(OPTION_TRENDS_LOCATION),
        builder: (context, snapshot) {
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
                  FutureBuilderWrapper<List<Trends>>(
                    future: model.loadTrends(place.woeid!),
                    onError: (error, stackTrace) {
                      return Center(
                        child: Text('$error'),
                      );
                    },
                    onReady: (data) {
                      var trends = data![0].trends;
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
                  ),
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