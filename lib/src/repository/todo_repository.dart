// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/repository/database_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';

/// The class that manages [TODO] repository.
class TodoRepository extends MytodoDatabaseProvider {
  @override
  String get tableName => 'TODO';

  @override
  createDatabase(Database database, int version) => database.execute(
        """
          CREATE TABLE $tableName(
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            NAME TEXT,
            TAG TEXT,
            PRIORITY INTEGER,
            DEADLINE DATETIME,
            DELETED BOOLEAN,
            COMPLETED BOOLEAN,
            COMPLETED_AT DATETIME
          )
        """,
      );
}
