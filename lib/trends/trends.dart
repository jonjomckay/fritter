import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  _TrendsScreenState createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context);

    return SingleChildScrollView(
      child: StreamBuilder<String>(
        stream: prefs.stream(optionTrendsLocation),
        builder: (context, snapshot) {
          var error = snapshot.error;
          if (error != null) {
            return FullPageErrorWidget(
              error: error,
              stackTrace: snapshot.stackTrace,
              prefix: L10n.of(context).unable_to_stream_the_trend_location_preference,
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.active:
              var place = TrendLocation.fromJson(jsonDecode(snapshot.data!));

              return Column(
                children: [
                  ListTile(
                      title: Text('${place.name} ${L10n.of(context).trends}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () async => showDialog(
                                context: context,
                                builder: (context) {
                                  return const TrendsSettings();
                                }),
                          )
                        ],
                      )),
                  TrendsList(place: place),
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
