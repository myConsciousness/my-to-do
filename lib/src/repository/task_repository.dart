// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/config/table_names.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepository extends Repository<Task> {
  @override
  String get table => TableNames.TASK;

  @override
  Future<List<Task>> findAll() async {
    return await super.database.then((Database v) => v.query(table).then(
        (List<Map<String, Object?>> v) => v
            .map((Map<String, Object?> e) =>
                e.isNotEmpty ? Task.fromMap(e) : Task.empty())
            .toList()));
  }

  @override
  Future<Task> findById(int id) async {
    return await super.database.then((Database database) => database
        .query(table, where: 'ID = ?', whereArgs: [id]).then(
            (v) => v.isNotEmpty ? Task.fromMap(v[0]) : Task.empty()));
  }

  @override
  Future<Task> insert(Task task) async {
    await super.database.then((Database v) =>
        v.insert(table, task.toMap()).then((int v) => task.id = v));
    return task;
  }

  @override
  void update(Task task) async {
    await super.database.then((Database database) => database
        .update(table, task.toMap(), where: 'ID = ?', whereArgs: [task.id]));
  }

  @override
  void delete(Task task) async {
    await super.database.then((Database database) =>
        database.delete(table, where: 'ID = ?', whereArgs: [task.id]));
  }
}
