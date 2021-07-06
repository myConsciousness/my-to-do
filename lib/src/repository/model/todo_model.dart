// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The entity class that manages the [TODO] model.
class Todo {
  ///  The id
  int id;

  /// The name
  String name;

  /// The remarks
  String remarks;

  /// The tag
  String tag;

  /// The priority
  String priority;

  /// The deadline
  DateTime deadline;

  /// The deleted
  bool deleted;

  /// The completed
  bool completed;

  /// The completed datetime
  DateTime completedAt;

  /// Returns the new instance of [Todo] based on the parameters.
  Todo.from(
      {required this.id,
      required this.name,
      required this.remarks,
      required this.tag,
      required this.priority,
      required this.deadline,
      required this.deleted,
      required this.completed,
      required this.completedAt});

  /// Returns the new instance of [Todo] based on the [json] parameter.
  Todo.fromJson(Map json)
      : this.id = json[_ColumnName.NAME],
        this.name = json[_ColumnName.NAME],
        this.remarks = json[_ColumnName.REMARKS],
        this.tag = json[_ColumnName.TAG],
        this.priority = json[_ColumnName.PRIORITY],
        this.deadline = json[_ColumnName.DEADLINE],
        this.deleted = json[_ColumnName.DELETED],
        this.completed = json[_ColumnName.COMPLETED],
        this.completedAt = json[_ColumnName.COMPLETED_AT];

  /// Returns this [Todo] model as [Map].
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[_ColumnName.ID] = this.id;
    map[_ColumnName.NAME] = this.name;
    map[_ColumnName.REMARKS] = this.remarks;
    map[_ColumnName.TAG] = this.tag;
    map[_ColumnName.PRIORITY] = this.priority;
    map[_ColumnName.DEADLINE] = this.deadline;
    map[_ColumnName.DELETED] = this.deleted;
    map[_ColumnName.COMPLETED] = this.completed;
    map[_ColumnName.COMPLETED_AT] = this.completedAt;

    return map;
  }
}

/// The internal const class that manages the column name of [TODO] repository.
class _ColumnName {
  /// The id
  static const String ID = 'id';

  /// The name
  static const String NAME = 'name';

  /// The remarks
  static const String REMARKS = 'remarks';

  /// The tag
  static const String TAG = 'tag';

  /// The priority
  static const String PRIORITY = 'priority';

  /// The deadline
  static const String DEADLINE = 'deadline';

  /// The deleted
  static const String DELETED = 'deleted';

  /// The completed
  static const String COMPLETED = 'completed';

  /// The completed datetime
  static const String COMPLETED_AT = 'completed_at';
}
