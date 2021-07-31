// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/config/priority.dart';
import 'package:mytodo/src/repository/boolean_text.dart';

/// The entity class that manages the [TASK] model.
class Task {
  /// The tag delimiter
  static const String _TAG_DELIMITER = '@';

  ///  The id
  int id = -1;

  /// The name
  String name;

  /// The remarks
  String remarks;

  /// The tag
  List<String> tags = <String>[];

  /// The priority
  Priority priority;

  /// The flag if the task has deadline
  bool hasDeadline;

  /// The deadline
  DateTime deadline;

  /// The favorited
  bool favorited = false;

  /// The deleted
  bool deleted = false;

  /// The completed
  bool completed = false;

  /// The created datetime
  DateTime createdAt = DateTime.now();

  /// The updated datetime
  DateTime updatedAt = DateTime.now();

  /// The flag that represents if this model is exist
  bool _empty = false;

  /// Returns the empty instance of [Task].
  Task.empty()
      : this._empty = true,
        this.id = -1,
        this.name = '',
        this.remarks = '',
        this.priority = Priority.LOW,
        this.hasDeadline = false,
        this.deadline = DateTime(0);

  /// Returns the new instance of [Todo] based on the parameters.
  Task.from(
      {this.id = -1,
      required this.name,
      required this.remarks,
      required this.tags,
      required this.priority,
      required this.hasDeadline,
      required this.deadline,
      this.favorited = false,
      this.deleted = false,
      this.completed = false,
      required this.createdAt,
      required this.updatedAt});

  /// Returns the new instance of [Todo] based on the [map] passed as an argument.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.from(
        id: map[_ColumnName.ID],
        name: map[_ColumnName.NAME],
        remarks: map[_ColumnName.REMARKS],
        tags: map[_ColumnName.TAG].toString().isNotEmpty
            ? map[_ColumnName.TAG].toString().split(_TAG_DELIMITER)
            : [],
        priority: map[_ColumnName.PRIORITY] == 0 ? Priority.LOW : Priority.HIGH,
        hasDeadline: map[_ColumnName.HAS_DEADLINE] == BooleanText.TRUE,
        deadline:
            DateTime.fromMillisecondsSinceEpoch(map[_ColumnName.DEADLINE]),
        favorited: map[_ColumnName.FAVORITED] == BooleanText.TRUE,
        deleted: map[_ColumnName.DELETED] == BooleanText.TRUE,
        completed: map[_ColumnName.COMPLETED] == BooleanText.TRUE,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            map[_ColumnName.CREATED_AT] == null
                ? 0
                : map[_ColumnName.CREATED_AT]),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(
            map[_ColumnName.UPDATED_AT] == null
                ? 0
                : map[_ColumnName.UPDATED_AT]));
  }

  /// Returns this [Todo] model as [Map].
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[_ColumnName.NAME] = this.name;
    map[_ColumnName.REMARKS] = this.remarks;
    map[_ColumnName.TAG] = this.tags.join(_TAG_DELIMITER);
    map[_ColumnName.PRIORITY] = this.priority == Priority.LOW ? 0 : 1;
    map[_ColumnName.HAS_DEADLINE] =
        this.hasDeadline ? BooleanText.TRUE : BooleanText.FALSE;
    map[_ColumnName.DEADLINE] = this.deadline.millisecondsSinceEpoch;
    map[_ColumnName.FAVORITED] =
        this.favorited ? BooleanText.TRUE : BooleanText.FALSE;
    map[_ColumnName.DELETED] =
        this.deleted ? BooleanText.TRUE : BooleanText.FALSE;
    map[_ColumnName.COMPLETED] =
        this.completed ? BooleanText.TRUE : BooleanText.FALSE;
    map[_ColumnName.CREATED_AT] = this.createdAt.millisecondsSinceEpoch;
    map[_ColumnName.UPDATED_AT] = this.updatedAt.millisecondsSinceEpoch;

    return map;
  }

  /// Returns [true] if this model is empty, otherwise [false].
  bool isEmpty() => this._empty;
}

/// The internal const class that manages the column name of [TODO] repository.
class _ColumnName {
  /// The id
  static const String ID = 'ID';

  /// The name
  static const String NAME = 'NAME';

  /// The remarks
  static const String REMARKS = 'REMARKS';

  /// The tag
  static const String TAG = 'TAG';

  /// The priority
  static const String PRIORITY = 'PRIORITY';

  /// The has deadline
  static const String HAS_DEADLINE = 'HAS_DEADLINE';

  /// The deadline
  static const String DEADLINE = 'DEADLINE';

  /// The favorited
  static const String FAVORITED = 'FAVORITED';

  /// The deleted
  static const String DELETED = 'DELETED';

  /// The completed
  static const String COMPLETED = 'COMPLETED';

  /// The created datetime
  static const String CREATED_AT = 'CREATED_AT';

  /// The updated datetime
  static const String UPDATED_AT = 'UPDATED_AT';
}
