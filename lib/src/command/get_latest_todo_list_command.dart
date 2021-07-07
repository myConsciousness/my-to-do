// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command.dart';
import 'package:mytodo/src/repository/model/todo_model.dart';
import 'package:mytodo/src/repository/todo_repository.dart';

class GetLatestTodoListCommand implements Command {
  /// The constructor.
  GetLatestTodoListCommand.newInstance();

  @override
  List<Card> execute() {
    return <Card>[
      Card(
        child: Column(
            mainAxisSize: MainAxisSize.min, children: this._buildTodoList()),
      )
    ];
  }

  List<Widget> _buildTodoList() {
    final List<Widget> todoList = <Widget>[];

    TodoRepository().findAll().then((List<Todo> v) => v.forEach((Todo todo) {
          todoList.add(ListTile(
            leading: Icon(Icons.priority_high),
            title: Text(todo.name),
            subtitle: Text(todo.remarks),
          ));

          todoList.add(Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Edit'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Complete'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ));
        }));

    return todoList;
  }
}
