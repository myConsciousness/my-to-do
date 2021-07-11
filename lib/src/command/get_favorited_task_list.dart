// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';

class GetFavoritedTaskListCommand implements Command {
  /// The constructor.
  GetFavoritedTaskListCommand.newInstance();

  @override
  Container execute() {
    return Container(
        child: FutureBuilder(
      future:
          TaskService.getInstance().findFavoritedAndNotCompletedAndNotDeleted(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return this._buildTaskCard(context, snapshot.data[index]);
            });
      },
    ));
  }

  Card _buildTaskCard(BuildContext context, Task task) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(this._getPriorityIcon(task.priority)),
        title: Text(task.id.toString()),
        subtitle: Text(task.completed.toString() + task.deleted.toString()),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        TextButton(
          child: const Text('Edit'),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Editted!')));
          },
        ),
        const SizedBox(width: 8),
        TextButton(
          child: const Text('Complete'),
          onPressed: () {
            task.completed = true;
            TaskService.getInstance().update(task);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Completed!')));
          },
        ),
        const SizedBox(width: 8),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            task.deleted = true;
            TaskService.getInstance().update(task);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Deleted!')));
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
