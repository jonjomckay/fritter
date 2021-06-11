import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_plan/migration/sql.dart';
import 'package:sqflite_migration_plan/sqflite_migration_plan.dart';
import 'package:uuid/uuid.dart';

const String DATABASE_NAME = 'fritter.db';

const String TABLE_SAVED_TWEET = 'saved_tweet';
const String TABLE_SUBSCRIPTION = 'subscription';
const String TABLE_SUBSCRIPTION_GROUP = 'subscription_group';
const String TABLE_SUBSCRIPTION_GROUP_MEMBER = 'subscription_group_member';

class Repository {
  static Future<Database> readOnly() async {
    return openDatabase(DATABASE_NAME, readOnly: true, singleInstance: false);
  }

  static Future<Database> writable() async {
    return openDatabase(DATABASE_NAME);
  }

  Future<bool> migrate() async {
    MigrationPlan myMigrationPlan = MigrationPlan({
      2: [
        SqlMigration('CREATE TABLE IF NOT EXISTS following (id INTEGER PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
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
      6: [
        // Rename the old following tables to match the names in the UI
        SqlMigration('ALTER TABLE following RENAME TO $TABLE_SUBSCRIPTION'),
        SqlMigration('ALTER TABLE following_group RENAME TO $TABLE_SUBSCRIPTION_GROUP'),
        SqlMigration('ALTER TABLE following_group_profile RENAME TO $TABLE_SUBSCRIPTION_GROUP_MEMBER'),
      ],
      7: [
        // Add the table for saved tweets
        SqlMigration('CREATE TABLE IF NOT EXISTS $TABLE_SAVED_TWEET (id VARCHAR PRIMARY KEY, content TEXT NOT NULL, saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)', reverseSql: 'DROP TABLE $TABLE_SAVED_TWEET')
      ],
      8: [
        // Add a primary key to the $TABLE_SUBSCRIPTION_GROUP_MEMBER table to prevent duplicates
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP_MEMBER RENAME TO ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old'),
        SqlMigration('CREATE TABLE $TABLE_SUBSCRIPTION_GROUP_MEMBER (group_id INTEGER, profile_id VARCHAR, CONSTRAINT pk_$TABLE_SUBSCRIPTION_GROUP_MEMBER PRIMARY KEY (group_id, profile_id))'),
        SqlMigration('INSERT INTO $TABLE_SUBSCRIPTION_GROUP_MEMBER (group_id, profile_id) SELECT group_id, profile_id FROM ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old'),
        SqlMigration('DROP TABLE ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old')
      ],
      9: [
        // Add a new ID field for subscription groups for a UUID to determine uniqueness across devices
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP ADD COLUMN uuid VARCHAR NULL'),
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP_MEMBER ADD COLUMN group_uuid VARCHAR NULL'),

        // Generate a UUID for each existing subscription group
        Migration(Operation((db) async {
          var uuid = Uuid();

          // Update the existing subscription group and all of its members with the new ID
          var groups = await db.query(TABLE_SUBSCRIPTION_GROUP);
          for (var group in groups) {
            var oldId = group['id'];
            var newId = uuid.v4();

            db.update(TABLE_SUBSCRIPTION_GROUP, {
              'uuid': newId
            }, where: 'id = ?', whereArgs: [oldId]);

            db.update(TABLE_SUBSCRIPTION_GROUP_MEMBER, {
              'group_uuid': newId
            }, where: 'group_id = ?', whereArgs: [oldId]);
          }
        })),

        // Replace the old ID fields with the new ones
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP RENAME TO ${TABLE_SUBSCRIPTION_GROUP}_old'),
        SqlMigration('CREATE TABLE $TABLE_SUBSCRIPTION_GROUP (id VARCHAR PRIMARY KEY, name VARCHAR NOT NULL, icon VARCHAR NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration('INSERT INTO $TABLE_SUBSCRIPTION_GROUP (id, name, icon, created_at) SELECT uuid, name, icon, created_at FROM ${TABLE_SUBSCRIPTION_GROUP}_old'),

        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP_MEMBER RENAME TO ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old'),
        SqlMigration('CREATE TABLE $TABLE_SUBSCRIPTION_GROUP_MEMBER (group_id VARCHAR, profile_id VARCHAR, CONSTRAINT pk_$TABLE_SUBSCRIPTION_GROUP_MEMBER PRIMARY KEY (group_id, profile_id))'),
        SqlMigration('INSERT INTO $TABLE_SUBSCRIPTION_GROUP_MEMBER (group_id, profile_id) SELECT group_uuid, profile_id FROM ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old'),
      ],
      10: [
        // Drop the old subscription group tables now that we've replaced the IDs
        SqlMigration('DROP TABLE ${TABLE_SUBSCRIPTION_GROUP}_old'),
        SqlMigration('DROP TABLE ${TABLE_SUBSCRIPTION_GROUP_MEMBER}_old'),
      ],
      11: [
        // Add columns for the subscription group settings
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP ADD COLUMN include_replies BOOLEAN DEFAULT true'),
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION_GROUP ADD COLUMN include_retweets BOOLEAN DEFAULT true')
      ],
      12: [
        // Insert a dummy record for the "All" subscription group
        Migration(Operation((db) async {
          await db.insert(TABLE_SUBSCRIPTION_GROUP, {
            'id': '-1',
            'name': 'All',
            'icon': 'rss_feed'
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }), reverse: Operation((db) async {
          await db.delete(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: ['-1']);
        })),
      ],
      13: [
        // Duplicate migration 12, as some people had deleted the "All" group when it displayed twice in the groups list
        Migration(Operation((db) async {
          await db.insert(TABLE_SUBSCRIPTION_GROUP, {
            'id': '-1',
            'name': 'All',
            'icon': 'rss_feed'
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }), reverse: Operation((db) async {
          await db.delete(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: ['-1']);
        })),
      ],
      14: [
        // Add a "verified" column to the subscriptions table
        SqlMigration('ALTER TABLE $TABLE_SUBSCRIPTION ADD COLUMN verified BOOLEAN DEFAULT false', reverseSql: 'ALTER TABLE $TABLE_SUBSCRIPTION DROP COLUMN verified')
      ]
    });

    await openDatabase(DATABASE_NAME,
        version: 14,
        onUpgrade: myMigrationPlan,
        onCreate: myMigrationPlan,
        onDowngrade: myMigrationPlan
    );

    log('Finished migrating database');

    return true;
  }
}