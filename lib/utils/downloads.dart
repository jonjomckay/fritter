import 'dart:io';

import 'package:fritter/catcher/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:pref/pref.dart';

Future<void> downloadUriToPickedFile(BuildContext context, Uri uri, String fileName,
    {required Function() onStart, required Function() onSuccess}) async {
  var sanitizedFilename = fileName.split("?")[0];

  try {
    var isLegacy = await isLegacyAndroid();
    if (isLegacy) {
      // This platform is too old to support a directory picker, so we just save the file to a predefined location
      var fullPath = await getLegacyPath(sanitizedFilename);

      await Directory(p.dirname(fullPath)).create(recursive: true);

      var response = await downloadFile(context, uri);
      if (response != null) {
        await File(fullPath).writeAsBytes(response);

        onSuccess();
      }
    } else {
      onStart();
      var responseTask = downloadFile(context, uri);

      var storagePermission = await Permission.storage.request();

      var response = await responseTask;
      if (response == null) {
        return;
      }

      final downloadType = PrefService.of(context).get(optionDownloadType);
      final downloadPath = PrefService.of(context).get(optionDownloadPath);

      // If the user wants to pick a file every time a download happens
      if (downloadType == optionDownloadTypeAsk || downloadPath == '') {
        var fileInfo =
            await FlutterFileDialog.saveFile(params: SaveFileDialogParams(fileName: sanitizedFilename, data: response));
        if (fileInfo == null) {
          return;
        }

        onSuccess();
        return;
      }

      // Otherwise, check we have the storage permission
      if (!storagePermission.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(L10n.current.permission_not_granted),
            action: SnackBarAction(
              label: L10n.current.open_app_settings,
              onPressed: openAppSettings,
            ),
          ),
        );

        await openAppSettings();
        return;
      }

      // Finally, save to the user-defined directory
      var savedFile = p.join(downloadPath, sanitizedFilename);
      await File(savedFile).writeAsBytes(response);
      onSuccess();
    }
  } catch (e, s) {
    Catcher.reportException(UnableToSaveMedia(uri, e), s);
    showSnackBar(context, icon: '🙊', message: e.toString());
  }
}

class UnableToSaveMedia implements SyntheticException {
  final Uri uri;
  final Object e;

  UnableToSaveMedia(this.uri, this.e);

  @override
  String toString() {
    return 'Unable to save the media {uri: $uri, e: $e}';
  }
}

Future downloadFile(BuildContext context, Uri uri) async {
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    return response.bodyBytes;
  }

  Catcher.reportSyntheticException(UnableToSaveMedia(uri, response.body));

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      L10n.of(context).unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode(response.statusCode),
    ),
  ));
  
  return null;
}
