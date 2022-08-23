import 'package:device_info/device_info.dart';
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
  if (deviceInfo.version.sdkInt < 19) {
    return true;
  }

  return false;
}