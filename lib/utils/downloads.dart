import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:pref/pref.dart';

Future downloadUriToPickedFile(BuildContext context, String uri, String fileName,
    {required Function(http.Response response) onError,
    required Function() onStart,
    required Function() onSuccess}) async {
  var sanitizedFilename = fileName.split("?")[0];

  var downloadFile = () async {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }

    onError(response);
    return null;
  };

  var isLegacy = await isLegacyAndroid();
  if (isLegacy) {
    // This platform is too old to support a directory picker, so we just save the file to a predefined location
    var fullPath = await getLegacyPath(sanitizedFilename);

    await Directory(path.dirname(fullPath)).create(recursive: true);

    var response = await downloadFile();
    if (response != null) {
      await File(fullPath).writeAsBytes(response);

      onSuccess();
    }
  } else {
    onStart();
    var response = await downloadFile();

    final prefDownloadType = PrefService.of(context).get(optionDownloadType);
    final prefDownloadPath = PrefService.of(context).get(optionDownloadPath);

    if (prefDownloadType == 'save_files_to' && prefDownloadPath != '') {
      if (await Permission.manageExternalStorage.request().isGranted ||
          await Permission.storage.request().isGranted) {
        if (response != null) {
          final File _localFile = File('$prefDownloadPath/$sanitizedFilename');
          final sponse = await _localFile.writeAsBytes(response);
          print(sponse.path);
        }
        onSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Not granted'),
            action: SnackBarAction(label: 'Open App settings',
            onPressed: openAppSettings,
            ),
          ),
        );
        await openAppSettings();
        print('can not write anything, opening Settings');
      }
    } else {
      var response = await downloadFile();

      var fileInfo =
          await FlutterFileDialog.saveFile(params: SaveFileDialogParams(fileName: sanitizedFilename, data: response));
      if (fileInfo == null) {
        return;
      }
    }

    onSuccess();
  }
}