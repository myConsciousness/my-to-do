// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/task_repository.dart';

class GetLatestTaskListCommand implements Command {
  /// The constructor.
  GetLatestTaskListCommand.newInstance();

  @override
  List<Card> execute() {
    return <Card>[
      Card(
          child: FutureBuilder(
              future: TodoRepository().findAll(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: this._buildTaskList(snapshot.data)));
              }))
    ];
  }

  List<Widget> _buildTaskList(List<Task> tasks) {
    final List<Widget> taskList = <Widget>[];

    for (Task task in tasks) {
      taskList.add(ListTile(
        leading: Icon(Icons.priority_high),
        title: Text(task.name),
        subtitle: Text(task.remarks),
      ));
      taskList
          .add(Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
      ]));
    }
    return taskList;
  }
}
