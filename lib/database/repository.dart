import 'package:fritter/group/group_model.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_plan/migration/sql.dart';
import 'package:sqflite_migration_plan/sqflite_migration_plan.dart';
import 'package:uuid/uuid.dart';

const String databaseName = 'fritter.db';

const String tableSavedTweet = 'saved_tweet';
const String tableSubscription = 'subscription';
const String tableSubscriptionGroup = 'subscription_group';
const String tableSubscriptionGroupMember = 'subscription_group_member';

class Repository {
  static final log = Logger('Repository');

  static Future<Database> readOnly() async {
    return openDatabase(databaseName, readOnly: true, singleInstance: false);
  }

  static Future<Database> writable() async {
    return openDatabase(databaseName);
  }

  Future<bool> migrate() async {
    MigrationPlan myMigrationPlan = MigrationPlan({
      2: [
        SqlMigration(
            'CREATE TABLE IF NOT EXISTS following (id INTEGER PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
      ],
      3: [
        SqlMigration(
            'CREATE TABLE IF NOT EXISTS following_group (id INTEGER PRIMARY KEY, name VARCHAR NOT NULL, icon VARCHAR NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration('CREATE TABLE IF NOT EXISTS following_group_profile (group_id INTEGER, profile_id INTEGER)')
      ],
      4: [
        // Change the following table's "id" field to be a VARCHAR
        SqlMigration('ALTER TABLE following RENAME TO following_old'),
        SqlMigration(
            'CREATE TABLE following (id VARCHAR PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration(
            'INSERT INTO following (id, screen_name, name, profile_image_url_https, created_at) SELECT id, screen_name, name, profile_image_url_https, created_at FROM following_old'),
        SqlMigration('DROP TABLE following_old')
      ],
      5: [
        // Change the following_group_profile table's "profile_id" field to be a VARCHAR to match the referenced table
        SqlMigration('ALTER TABLE following_group_profile RENAME TO following_group_profile_old'),
        SqlMigration('CREATE TABLE following_group_profile (group_id INTEGER, profile_id VARCHAR)'),
        SqlMigration(
            'INSERT INTO following_group_profile (group_id, profile_id) SELECT group_id, profile_id FROM following_group_profile_old'),
        SqlMigration('DROP TABLE following_group_profile_old')
      ],
      6: [
        // Rename the old following tables to match the names in the UI
        SqlMigration('ALTER TABLE following RENAME TO $tableSubscription'),
        SqlMigration('ALTER TABLE following_group RENAME TO $tableSubscriptionGroup'),
        SqlMigration('ALTER TABLE following_group_profile RENAME TO $tableSubscriptionGroupMember'),
      ],
      7: [
        // Add the table for saved tweets
        SqlMigration(
            'CREATE TABLE IF NOT EXISTS $tableSavedTweet (id VARCHAR PRIMARY KEY, content TEXT NOT NULL, saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)',
            reverseSql: 'DROP TABLE $tableSavedTweet')
      ],
      8: [
        // Add a primary key to the $TABLE_SUBSCRIPTION_GROUP_MEMBER table to prevent duplicates
        SqlMigration('ALTER TABLE $tableSubscriptionGroupMember RENAME TO ${tableSubscriptionGroupMember}_old'),
        SqlMigration(
            'CREATE TABLE $tableSubscriptionGroupMember (group_id INTEGER, profile_id VARCHAR, CONSTRAINT pk_$tableSubscriptionGroupMember PRIMARY KEY (group_id, profile_id))'),
        SqlMigration(
            'INSERT INTO $tableSubscriptionGroupMember (group_id, profile_id) SELECT group_id, profile_id FROM ${tableSubscriptionGroupMember}_old'),
        SqlMigration('DROP TABLE ${tableSubscriptionGroupMember}_old')
      ],
      9: [
        // Add a new ID field for subscription groups for a UUID to determine uniqueness across devices
        SqlMigration('ALTER TABLE $tableSubscriptionGroup ADD COLUMN uuid VARCHAR NULL'),
        SqlMigration('ALTER TABLE $tableSubscriptionGroupMember ADD COLUMN group_uuid VARCHAR NULL'),

        // Generate a UUID for each existing subscription group
        Migration(Operation((db) async {
          var uuid = const Uuid();

          // Update the existing subscription group and all of its members with the new ID
          var groups = await db.query(tableSubscriptionGroup);
          for (var group in groups) {
            var oldId = group['id'];
            var newId = uuid.v4();

            db.update(tableSubscriptionGroup, {'uuid': newId}, where: 'id = ?', whereArgs: [oldId]);

            db.update(tableSubscriptionGroupMember, {'group_uuid': newId}, where: 'group_id = ?', whereArgs: [oldId]);
          }
        })),

        // Replace the old ID fields with the new ones
        SqlMigration('ALTER TABLE $tableSubscriptionGroup RENAME TO ${tableSubscriptionGroup}_old'),
        SqlMigration(
            'CREATE TABLE $tableSubscriptionGroup (id VARCHAR PRIMARY KEY, name VARCHAR NOT NULL, icon VARCHAR NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration(
            'INSERT INTO $tableSubscriptionGroup (id, name, icon, created_at) SELECT uuid, name, icon, created_at FROM ${tableSubscriptionGroup}_old'),

        SqlMigration('ALTER TABLE $tableSubscriptionGroupMember RENAME TO ${tableSubscriptionGroupMember}_old'),
        SqlMigration(
            'CREATE TABLE $tableSubscriptionGroupMember (group_id VARCHAR, profile_id VARCHAR, CONSTRAINT pk_$tableSubscriptionGroupMember PRIMARY KEY (group_id, profile_id))'),
        SqlMigration(
            'INSERT INTO $tableSubscriptionGroupMember (group_id, profile_id) SELECT group_uuid, profile_id FROM ${tableSubscriptionGroupMember}_old'),
      ],
      10: [
        // Drop the old subscription group tables now that we've replaced the IDs
        SqlMigration('DROP TABLE ${tableSubscriptionGroup}_old'),
        SqlMigration('DROP TABLE ${tableSubscriptionGroupMember}_old'),
      ],
      11: [
        // Add columns for the subscription group settings
        SqlMigration('ALTER TABLE $tableSubscriptionGroup ADD COLUMN include_replies BOOLEAN DEFAULT true'),
        SqlMigration('ALTER TABLE $tableSubscriptionGroup ADD COLUMN include_retweets BOOLEAN DEFAULT true')
      ],
      12: [
        // Insert a dummy record for the "All" subscription group
        Migration(Operation((db) async {
          await db.insert(tableSubscriptionGroup, {'id': '-1', 'name': 'All', 'icon': 'rss_feed'},
              conflictAlgorithm: ConflictAlgorithm.replace);
        }), reverse: Operation((db) async {
          await db.delete(tableSubscriptionGroup, where: 'id = ?', whereArgs: ['-1']);
        })),
      ],
      13: [
        // Duplicate migration 12, as some people had deleted the "All" group when it displayed twice in the groups list
        Migration(Operation((db) async {
          await db.insert(tableSubscriptionGroup, {'id': '-1', 'name': 'All', 'icon': 'rss_feed'},
              conflictAlgorithm: ConflictAlgorithm.replace);
        }), reverse: Operation((db) async {
          await db.delete(tableSubscriptionGroup, where: 'id = ?', whereArgs: ['-1']);
        })),
      ],
      14: [
        // Add a "verified" column to the subscriptions table
        SqlMigration('ALTER TABLE $tableSubscription ADD COLUMN verified BOOLEAN DEFAULT 0',
            reverseSql: 'ALTER TABLE $tableSubscription DROP COLUMN verified')
      ],
      15: [
        // Re-apply migration 14 in a different way, as it looks like it didn't apply for some people
        SqlMigration('ALTER TABLE $tableSubscription RENAME TO ${tableSubscription}_old'),
        SqlMigration(
            'CREATE TABLE $tableSubscription (id VARCHAR PRIMARY KEY, screen_name VARCHAR, name VARCHAR, profile_image_url_https VARCHAR, verified BOOLEAN DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
        SqlMigration(
            'INSERT INTO $tableSubscription (id, screen_name, name, profile_image_url_https, created_at) SELECT id, screen_name, name, profile_image_url_https, created_at FROM ${tableSubscription}_old'),
        SqlMigration('DROP TABLE ${tableSubscription}_old'),
      ],
      16: [
        // Add a "color" column to the subscription groups table, and set a default icon for existing groups
        SqlMigration('ALTER TABLE $tableSubscriptionGroup ADD COLUMN color INT DEFAULT NULL',
            reverseSql: 'ALTER TABLE $tableSubscriptionGroup DROP COLUMN color'),

        Migration(Operation((db) async {
          await db.update(tableSubscriptionGroup, {'icon': defaultGroupIcon},
              where: "icon IS NULL OR icon = '' OR icon = ?", whereArgs: ['rss_feed']);
        }))
      ]
    });
    await openDatabase(
      databaseName,
      version: 16,
      onUpgrade: myMigrationPlan,
      onCreate: myMigrationPlan,
      onDowngrade: myMigrationPlan,
    );

    log.info('Finished migrating database');

    return true;
  }
}
