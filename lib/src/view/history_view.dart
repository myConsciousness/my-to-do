// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';
import 'package:mytodo/src/view/widget/info_snackbar.dart';

class HistoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _Text {
  static const String APP_BAR_TITLE = 'History';
}

class _State extends State<HistoryView> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(_Text.APP_BAR_TITLE),
      ),
      body: Container(
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
      )));

  Card _buildTaskCard(BuildContext context, Task task) => Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          leading: Icon(this._getHistoryIcon(task)),
          title: Text(task.name),
          subtitle: Text(task.remarks),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          TextButton(
            child: const Icon(Icons.undo),
            onPressed: () {
              if (task.completed) {
                task.completed = false;
              } else {
                task.deleted = false;
              }

              super.setState(() {
                TaskService.getInstance().update(task);
              });

              InfoSnackbar.from(context).show(content: 'Undo Task!');
            },
          ),
          TextButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Delete Task"),
                    content: Text(
                        "Delete this task data. Once the data is deleted, it cannot be restored. Are you sure you want to delete?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          super.setState(() {
                            TaskService.getInstance().delete(task);
                          });

                          InfoSnackbar.from(context)
                              .show(content: 'Deleted Task!');

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ])
      ]));

  IconData _getHistoryIcon(Task task) =>
      task.completed ? Icons.done : Icons.delete;
}
