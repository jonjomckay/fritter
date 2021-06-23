import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';

class TrendsScreen extends StatefulWidget {
  @override
  _TrendsScreenState createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
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