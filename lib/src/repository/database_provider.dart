// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class MytodoDatabaseProvider {
  /// The database name
  static const String _DATABASE_NAME = 'mytodo.db';

  /// The database
  static Database? _database;

  /// Returns the table name.
  String get tableName;

  /// Returns the singleton instance of database.
  Future<Database?> get database async {
    if (_database == null) {
      _database = await openDatabase(
        join(
          await getDatabasesPath(),
          _DATABASE_NAME,
        ),
        onCreate: createDatabase,
        version: 1,
      );
    }

    return _database;
  }

  /// Creates database when the database does not exist.
  createDatabase(Database db, int version);
}
