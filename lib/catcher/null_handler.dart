import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';

class NullHandler extends ReportHandler {
  @override
  Future<bool> handle(Report error, BuildContext? context) async {
    // Do nothing
    return true;
  }

  @override
  List<PlatformType> getSupportedPlatforms() {
    return [
      PlatformType.android,
      PlatformType.iOS,
      PlatformType.web,
      PlatformType.linux,
      PlatformType.macOS,
      PlatformType.windows,
    ];
  }

}