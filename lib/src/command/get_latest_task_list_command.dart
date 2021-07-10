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
  Container execute() {
    return Container(
        child: FutureBuilder(
      future: TaskRepository().findAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return this._buildTaskCard(snapshot.data[index]);
            });
      },
    ));
  }

  Card _buildTaskCard(Task task) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(this._getPriorityIcon(task.priority)),
        title: Text(task.name),
        subtitle: Text(task.remarks),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
          onPressed: () {
            TaskRepository().delete(task);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Added!')));
          },
        ),
        const SizedBox(width: 8),
      ])
    ]));
  }

  IconData _getPriorityIcon(int priority) {
    return priority == 0 ? Icons.low_priority : Icons.priority_high;
  }
}
