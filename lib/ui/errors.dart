import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

abstract class FritterErrorWidget extends StatelessWidget {
  const FritterErrorWidget({Key? key}) : super(key: key);
}

class InlineErrorWidget extends FritterErrorWidget {
  final Object? error;

  const InlineErrorWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(Icons.error, color: Colors.red),
          ),
          Container(
            child: Text('$error', textAlign: TextAlign.center, style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          ),
        ],
      ),
    );
  }
}

class AlertErrorWidget extends FritterErrorWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final String prefix;

  const AlertErrorWidget({Key? key, required this.error, required this.stackTrace, required this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FullPageErrorWidget(error: error, prefix: prefix, stackTrace: stackTrace),
    );
  }
}

class ScaffoldErrorWidget extends FritterErrorWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final String prefix;

  const ScaffoldErrorWidget({Key? key, required this.error, required this.stackTrace, required this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FullPageErrorWidget(error: error, prefix: prefix, stackTrace: stackTrace),
    );
  }
}


class FullPageErrorWidget extends FritterErrorWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final String prefix;
  final Function? onRetry;

  const FullPageErrorWidget({Key? key, required this.error, required this.stackTrace, required this.prefix, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onRetry = this.onRetry;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Icon(Icons.error, color: Colors.red, size: 36),
          ),
          Text('Oops! Something went wrong 🥲', textAlign: TextAlign.center, style: TextStyle(
              fontSize: 18
          )),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text('$prefix', textAlign: TextAlign.center, style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text('$error', textAlign: TextAlign.center, style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: ElevatedButton(
              child: Text('Report'),
              onPressed: () => Catcher.reportCheckedError(error, stackTrace),
            ),
          ),
          if (onRetry != null)
            Container(
              margin: EdgeInsets.only(top: 12),
              child: ElevatedButton(
                child: Text('Retry'),
                onPressed: () => onRetry(),
              ),
            )
        ],
      ),
    );
  }
}
