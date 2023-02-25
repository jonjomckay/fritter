import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as p;

Future<String> getLegacyPath(String filename) async {
  var externalStorageDirectory = await p.getExternalStorageDirectory();
  if (externalStorageDirectory == null) {
    throw Exception('Unable to find the external storage directory');
  }

  return path.join(externalStorageDirectory.path, filename);
}

Future<bool> isLegacyAndroid() async {
  var deviceInfo = await DeviceInfoPlugin().androidInfo;
  var sdkVersion = deviceInfo.version.sdkInt;
  if (sdkVersion < 19) {
    return true;
  }

  return false;
}