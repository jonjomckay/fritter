
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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