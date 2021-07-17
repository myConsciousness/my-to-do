// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/src/config/priority.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';
import 'package:mytodo/src/view/add_new_task_view.dart';
import 'package:mytodo/src/view/edit_task_view.dart';

class LatestTaskListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _Text {
  /// The app bar title
  static const String APP_BAR_TITLE = 'Task';

  /// The tooltip message of new task
  static const String ACTION_TOOLTIP_NEW_TASK = 'New Task';
}

class _State extends State<LatestTaskListView> {
  final TaskService taskService = TaskService.getInstance();

  final DateFormat _datetimeFormat = new DateFormat('yyyy/MM/dd HH:mm');

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(_Text.APP_BAR_TITLE),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: _Text.ACTION_TOOLTIP_NEW_TASK,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewTaskView()));
            },
          ),
          SizedBox(
            width: 19,
          )
        ],
      ),
      body: Container(
          child: FutureBuilder(
        future: this.taskService.findNotCompletedAndNotDeleted(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: ListTile(
              leading: Icon(this._getPriorityIcon(task.priority)),
              title: Text(task.name),
              subtitle: Text(task.remarks),
            )),
            TextButton(
              child: Icon(task.favorited ? Icons.star : Icons.star_border),
              onPressed: () {
                task.favorited = !task.favorited;

                super.setState(() {
                  this.taskService.update(task);
                });
              },
            ),
            SizedBox(width: 7),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 72,
                  ),
                  Text(
                    task.hasDeadline
                        ? this._datetimeFormat.format(task.deadline)
                        : '',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                TextButton(
                  child: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTaskView(task)));
                  },
                ),
                const SizedBox(width: 7),
                TextButton(
                  child: const Icon(Icons.done),
                  onPressed: () {
                    task.completed = true;
                    TaskService.getInstance().update(task);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Completed!')));
                  },
                ),
                const SizedBox(width: 7),
                TextButton(
                  child: const Icon(Icons.delete),
                  onPressed: () {
                    task.deleted = true;
                    TaskService.getInstance().update(task);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deleted!')));
                  },
                ),
                const SizedBox(width: 7),
              ])
            ])
      ]));

  IconData _getPriorityIcon(Priority? priority) =>
      priority == Priority.LOW ? Icons.low_priority : Icons.priority_high;
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu, progress: transitionAnimation));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu, progress: transitionAnimation));
  }
}
