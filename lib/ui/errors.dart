import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/client.dart';
import 'package:logging/logging.dart';

abstract class FritterErrorWidget extends StatelessWidget {
  const FritterErrorWidget({Key? key}) : super(key: key);
}

_EmojiErrorWidget createEmojiError(TwitterError error) {
  String emoji;
  String message;

  switch (error.code) {
    case 22:
      emoji = '🔒';
      message = 'Private profile';
      break;
    case 50:
      emoji = '🕵️';
      message = 'User not found';
      break;
    case 63:
      emoji = '👮';
      message = 'Account suspended';
      break;
    default:
      Logger.root.warning('Unsupported Twitter error code: ${error.code}', error.message);
      emoji = '💥';
      message = 'Catastrophic failure';
      break;
  }

  return _EmojiErrorWidget(
      emoji: emoji,
      message: message,
      errorMessage: error.message
  );
}

class _EmojiErrorWidget extends FritterErrorWidget {
  final String emoji;
  final String message;
  final String errorMessage;
  final Function? onRetry;

  const _EmojiErrorWidget({Key? key, required this.emoji, required this.message, required this.errorMessage, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onRetry = this.onRetry;

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(emoji, style: TextStyle(
                fontSize: 36
            )),
          ),
          Text(message, textAlign: TextAlign.center, style: TextStyle(
              fontSize: 18
          )),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text(errorMessage, textAlign: TextAlign.center, style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: ElevatedButton(
              child: Text('Back'),
              onPressed: () => Navigator.pop(context),
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

    var error = this.error;
    if (error is SocketException) {
      return _EmojiErrorWidget(
        emoji: '🔌',
        message: 'Could not contact Twitter',
        errorMessage: 'Please check your Internet connection.\n\n${error.message}',
        onRetry: onRetry,
      );
    }

    if (error is TwitterError) {
      return createEmojiError(error);
    }

    var message = error;
    if (message is HttpException) {
      var content = jsonDecode(message.body);

      var hasErrors = content.containsKey('errors');
      if (hasErrors && content['errors'] != null) {
        var errors = List.from(content['errors']);
        if (errors.isNotEmpty) {
          return createEmojiError(TwitterError(
            code: errors.first['code'],
            message: errors.first['message']
          ));
        }
      }

      message = JsonEncoder.withIndent(' ' * 2).convert(content);
    }

    if (message is TimeoutException) {
      return _EmojiErrorWidget(
        emoji: '⏱️',
        message: 'Timed out',
        errorMessage: 'This took too long to load. Please check your network connection!',
        onRetry: onRetry,
      );
    }

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
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 12),
            child: Text('$message', textAlign: TextAlign.left, style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: ElevatedButton(
              child: Text('Report'),
              onPressed: () => Catcher.reportCheckedError(ManuallyReportedException(error), stackTrace),
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