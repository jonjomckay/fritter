// import 'dart:developer';
//
// import 'package:fritter/catcher/errors.dart';
// import 'package:catcher/model/platform_type.dart';
// import 'package:flutter/material.dart';
//
// class NiceConsoleHandler extends ReportHandler {
//   @override
//   List<PlatformType> getSupportedPlatforms() => [
//         PlatformType.android,
//         PlatformType.iOS,
//         PlatformType.web,
//         PlatformType.linux,
//         PlatformType.macOS,
//         PlatformType.windows,
//       ];
//
//   @override
//   Future<bool> handle(Report error, BuildContext? context) async {
//     var details = error.errorDetails;
//
//     var message = details == null ? 'Unexpected error' : details.toStringShort();
//
//     try {
//       if (error.error is Error) {
//         log(message, error: error.error, stackTrace: error.error.stackTrace);
//       } else {
//         log(message, error: error.error, stackTrace: error.stackTrace);
//       }
//     } catch (e) {
//       // Fall back to our "safe" method, if our attempt at getting the inner stack trace doesn't work
//       log(message, error: error.error, stackTrace: error.stackTrace);
//     }
//
//     return true;
//   }
// }
