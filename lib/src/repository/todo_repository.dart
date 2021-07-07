// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/config/table_names.dart';
import 'package:mytodo/src/repository/model/todo_model.dart';
import 'package:mytodo/src/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepository extends Repository<Todo> {
  @override
  String get table => TableNames.TODO;

  @override
  Future<List<Todo>> findAll() async {
    return await super.database.then((Database v) => v.query(table).then(
        (List<Map<String, Object?>> v) => v
            .map((Map<String, Object?> e) =>
                e.isNotEmpty ? Todo.fromMap(e) : Todo.empty())
            .toList()));
  }

  @override
  Future<Todo> findById(int id) async {
    return await super.database.then((Database database) => database
        .query(table, where: 'ID = ?', whereArgs: [id]).then(
            (v) => v.isNotEmpty ? Todo.fromMap(v[0]) : Todo.empty()));
  }

  @override
  Future<Todo> insert(Todo todo) async {
    await super.database.then((Database v) =>
        v.insert(table, todo.toMap()).then((int v) => todo.id = v));
    return todo;
  }

  @override
  void update(Todo todo) async {
    await super.database.then((Database database) => database
        .update(table, todo.toMap(), where: 'ID = ?', whereArgs: [todo.id]));
  }

  @override
  void delete(Todo todo) async {
    await super.database.then((Database database) =>
        database.delete(table, where: 'ID = ?', whereArgs: [todo.id]));
  }
}
