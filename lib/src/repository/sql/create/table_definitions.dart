// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The class that manages table defintiions.
class TableDefinitions {
  /// The Todo table
  static const String TASK = '''
          CREATE TABLE TASK (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            NAME TEXT,
            REMARKS TEXT,
            TAG TEXT,
            PRIORITY INTEGER,
            HAS_DEADLINE INTEGER,
            DEADLINE INTEGER,
            FAVORITED TEXT,
            DELETED TEXT,
            COMPLETED TEXT,
            CREATED_AT INTEGER,
            UPDATED_AT INTEGER
          )
        ''';
}
