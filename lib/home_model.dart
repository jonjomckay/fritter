import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:sqflite/sqflite.dart';


class HomeModel extends ChangeNotifier {
  static final log = Logger('HomeModel');

  Future importData(Map<String, List<ToMappable>> data) async {
    var database = await Repository.writable();

    var batch = database.batch();

    for (var pair in data.entries) {
      for (var datum in pair.value) {
        batch.insert(pair.key, datum.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      log.info('Imported data into ${pair.key}');
    }

    await batch.commit();
  }
}
