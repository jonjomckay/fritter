import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:provider/provider.dart';

class TrendsScreen extends StatefulWidget with AppBarMixin {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: Text(L10n.current.trends),
      actions: createCommonAppBarActions(context),
    );
  }

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TrendLocationModel>().loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScopedBuilder<TrendLocationModel, Object, TrendLocation>.transition(
        store: context.read<TrendLocationModel>(),
        onLoading: (context) => const Center(child: CircularProgressIndicator()),
        onError: (context, e) => FullPageErrorWidget(
          error: e,
          // TODO: Use a tuple of (error, stackTrace)
          stackTrace: null,
          prefix: L10n.of(context).unable_to_stream_the_trend_location_preference,
        ),
        onState: (context, place) {
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
              const TrendsList(),
            ],
          );
        },
      ),
    );
  }
}
