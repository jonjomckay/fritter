import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrendsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return FutureBuilder<List<Trends>>(
            future: model.loadTrends(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return Center(child: CircularProgressIndicator());
              }

              var trends = data[0].trends;
              if (trends == null) {
                return Text('There were no trends returned. This is unexpected! Please report as a bug, if possible.');
              }

              var numberFormat = NumberFormat.compact();

              return ListView(
                children: [
                  Container(
                    child: ListTile(
                      title: Text('Worldwide trends', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                  ListView.builder(
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
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
