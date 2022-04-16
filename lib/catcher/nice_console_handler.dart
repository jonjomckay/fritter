import 'dart:developer';

import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';

class NiceConsoleHandler extends ReportHandler {
  @override
  List<PlatformType> getSupportedPlatforms() => [
        PlatformType.android,
        PlatformType.iOS,
        PlatformType.web,
        PlatformType.linux,
        PlatformType.macOS,
        PlatformType.windows,
      ];

  @override
  Future<bool> handle(Report error, BuildContext? context) async {
    var details = error.errorDetails;

    var message = details == null ? 'Unexepected error' : details.toStringShort();

    log(message, error: error.error, stackTrace: error.stackTrace);

    return true;
  }
}
