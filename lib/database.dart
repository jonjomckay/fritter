import 'package:sqflite/sqflite.dart';

class Repository {
  static Database? _database;

  static Future<Database> open() async {
    if (_database == null) {
      _database = await openDatabase('fritter.db', version: 1, onCreate: (db, version) async {
        var migrations = [
          'CREATE TABLE following (id INTEGER PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)',
        ];

        for (var migration in migrations) {
          await db.execute(migration);
        }
      });
    }

    return _database!;
  }
}