import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/futures.dart';
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

    return FutureBuilder<List<TrendLocation>>(
      future: Twitter.getTrendLocations(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        }

        data.sort((a, b) => a.name!.compareTo(b.name!));

        int _selected = prefs.get('trends.location.id');

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];

                  return RadioListTile<int?>(
                      title: Text(item.name!),
                      subtitle: Text(item.country!),
                      value: item.woeid,
                      selected: _selected == item.woeid,
                      groupValue: _selected,
                      onChanged: (value) async {
                        setState(() {
                          _selected = item.woeid!;
                        });

                        await model.setTrendLocation(prefs, item);
                      }
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }
}

class TrendsThing extends StatefulWidget {
  final int id;

  const TrendsThing({Key? key, required this.id}) : super(key: key);

  @override
  _TrendsThingState createState() => _TrendsThingState();
}

class _TrendsThingState extends State<TrendsThing> {
  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();
    var prefs = PrefService.of(context);
    var place = prefs.get('trends.location.name') ?? 'Worldwide';

    return Column(
      children: [
        Container(
          child: ListTile(
              title: Text('$place trends', style: TextStyle(
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
          future: model.loadTrends(widget.id),
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
      child: StreamBuilder<int>(
        stream: prefs.stream('trends.location.id'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return TrendsThing(id: snapshot.data ?? 1);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}