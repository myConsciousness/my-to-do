// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The entity class that manages the [LANGUAGE] model.
class Language {
  /// The id
  int id = -1;

  /// The code
  String code = '';

  /// The name
  String name = '';

  /// The sort order
  int sortOrder = -1;

  /// Returns the new instance of [Language] based on the parameters.
  Language.from(
      {id, required String code, required String name, required int sortOrder});

  /// Returns the new instance of [Language] based on the [map] passed as an argument.
  factory Language.fromMap(Map<String, dynamic> map) {
    return Language.from(
        id: map[_ColumnName.ID],
        code: map[_ColumnName.CODE],
        name: map[_ColumnName.NAME],
        sortOrder: map[_ColumnName.SORT_ORDER]);
  }

  static List<Language> getLanguages() {
    return <Language>[
      Language.from(code: 'en', name: 'English', sortOrder: 0),
      Language.from(code: 'jp', name: 'Japanese', sortOrder: 1)
    ];
  }
}

/// The internal const class that manages the column name of [LANGUAGE] repository.
class _ColumnName {
  /// The id
  static const String ID = 'ID';

  /// The code
  static const String CODE = 'CODE';

  /// The name
  static const String NAME = 'NAME';

  /// The sort order
  static const String SORT_ORDER = 'SORT_ORDER';
}
