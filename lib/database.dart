import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_plan/migration/sql.dart';
import 'package:sqflite_migration_plan/sqflite_migration_plan.dart';

const String DATABASE_NAME = 'fritter.db';

class Repository {
  static Future<Database> readOnly() async {
    return openDatabase(DATABASE_NAME, readOnly: true, singleInstance: false);
  }

  static Future<Database> writable() async {
    return openDatabase(DATABASE_NAME);
  }

  void migrate() async {
    MigrationPlan myMigrationPlan = MigrationPlan({
      2: [
        SqlMigration('CREATE TABLE following (id INTEGER PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
      ],
      3: [
        SqlMigration('CREATE TABLE IF NOT EXISTS following_group (id INTEGER PRIMARY KEY, name VARCHAR NOT NULL, icon VARCHAR NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration('CREATE TABLE IF NOT EXISTS following_group_profile (group_id INTEGER, profile_id INTEGER)')
      ],
      4: [
        // Change the following table's "id" field to be a VARCHAR
        SqlMigration('ALTER TABLE following RENAME TO following_old'),
        SqlMigration('CREATE TABLE following (id VARCHAR PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration('INSERT INTO following (id, screen_name, name, profile_image_url_https, created_at) SELECT id, screen_name, name, profile_image_url_https, created_at FROM following_old'),
        SqlMigration('DROP TABLE following_old')
      ],
      5: [
        // Change the following_group_profile table's "profile_id" field to be a VARCHAR to match the referenced table
        SqlMigration('ALTER TABLE following_group_profile RENAME TO following_group_profile_old'),
        SqlMigration('CREATE TABLE following_group_profile (group_id INTEGER, profile_id VARCHAR)'),
        SqlMigration('INSERT INTO following_group_profile (group_id, profile_id) SELECT group_id, profile_id FROM following_group_profile_old'),
        SqlMigration('DROP TABLE following_group_profile_old')
      ],
    });

    await openDatabase(DATABASE_NAME,
        version: 5,
        onUpgrade: myMigrationPlan,
        onCreate: myMigrationPlan,
        onDowngrade: myMigrationPlan
    );

    log('Finished migrating database');
  }
}