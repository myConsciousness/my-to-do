// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/config/priority.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';

class FavoritedTaskListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _Text {
  static const String APP_BAR_TITLE = 'Favorited Task';

  static const String ACTION_TOOLTIP_SEARCH = 'Search';

  static const String ACTION_TOOLTIP_SORT_ORDER = 'Sort Order';
}

class _State extends State<FavoritedTaskListView> {
  final TaskService taskService = TaskService.getInstance();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(_Text.APP_BAR_TITLE),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: _Text.ACTION_TOOLTIP_SEARCH,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: _Text.ACTION_TOOLTIP_SORT_ORDER,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(
          child: FutureBuilder(
        future: this.taskService.findFavoritedAndNotCompletedAndNotDeleted(),
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
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          TextButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Editted!')));
            },
          ),
          const SizedBox(width: 8),
          TextButton(
            child: const Icon(Icons.done),
            onPressed: () {
              task.completed = true;
              TaskService.getInstance().update(task);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Completed!')));
            },
          ),
          const SizedBox(width: 8),
          TextButton(
            child: const Icon(Icons.delete),
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
