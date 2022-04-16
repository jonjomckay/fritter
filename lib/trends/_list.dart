import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fritter/generated/l10n.dart';

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
        prefix: L10n.of(context).unable_to_load_the_trends_for_widget_place_name(
          widget.place.name!,
        ),
        onRetry: () => fetchTrends(),
      ),
      onReady: (data) {
        var trends = data[0].trends;
        if (trends == null) {
          return Text(
            L10n.of(context).there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible,
          );
        }

        var numberFormat = NumberFormat.compact();

        return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: trends.length,
          itemBuilder: (context, index) {
            var trend = trends[index];

            return ListTile(
              dense: true,
              leading: Text('${++index}'),
              title: Text(trend.name!),
              subtitle: trend.tweetVolume == null
                  ? null
                  : Text(
                      L10n.of(context).tweets_number(
                        trend.tweetVolume!,
                        numberFormat.format(trend.tweetVolume),
                      ),
                    ),
              onTap: () async {
                await showSearch(
                    context: context,
                    delegate: TweetSearchDelegate(initialTab: 1),
                    query: Uri.decodeQueryComponent(trend.query!));
              },
            );
          },
        );
      },
    );
  }
}
