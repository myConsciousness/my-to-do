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
  int priority;

  /// The deadline
  DateTime deadline;

  /// The deleted
  bool deleted;

  /// The completed
  bool completed;

  /// The completed datetime
  DateTime completedAt;

  /// The flag that represents if this model is exist
  bool _empty = false;

  Todo.empty()
      : this._empty = true,
        this.id = 0,
        this.name = '',
        this.remarks = '',
        this.tag = '',
        this.priority = 0,
        this.deadline = DateTime(0),
        this.deleted = false,
        this.completed = false,
        this.completedAt = DateTime(0);

  /// Returns the new instance of [Todo] based on the parameters.
  Todo.from(
      {this.id = 0,
      required this.name,
      required this.remarks,
      required this.tag,
      required this.priority,
      required this.deadline,
      required this.deleted,
      required this.completed,
      required this.completedAt});

  /// Returns the new instance of [Todo] based on the [map] passed as an argument.
  factory Todo.fromMap(Map<String, dynamic> map) => Todo.from(
      id: map[_ColumnName.ID],
      name: map[_ColumnName.NAME],
      remarks: map[_ColumnName.REMARKS],
      tag: map[_ColumnName.TAG],
      priority: map[_ColumnName.PRIORITY],
      deadline: map[_ColumnName.DEADLINE],
      deleted: map[_ColumnName.DELETED],
      completed: map[_ColumnName.COMPLETED],
      completedAt: map[_ColumnName.COMPLETED_AT]);

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

  /// Returns [true] if this model is empty, otherwise [false].
  bool isEmpty() {
    return this._empty;
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
