// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';

class GetTaskHistoryCommand implements Command {
  /// The constructor.
  GetTaskHistoryCommand.newInstance();

  @override
  Container execute() {
    return Container(
        child: FutureBuilder(
      future: TaskService.getInstance().findCompletedOrDeleted(),
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
        leading: Icon(this._getHistoryIcon(task)),
        title: Text(task.id.toString()),
        subtitle: Text(task.completed.toString() + task.deleted.toString()),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        TextButton(
          child: const Icon(Icons.undo),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Incompleted!')));
          },
        ),
        TextButton(
          child: const Icon(Icons.delete_forever),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Deleted!')));
          },
        )
      ])
    ]));
  }

  IconData _getHistoryIcon(Task task) {
    if (task.completed) {
      return Icons.done;
    }

    return Icons.delete;
  }
}
