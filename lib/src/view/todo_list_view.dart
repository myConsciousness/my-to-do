// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command_exporter.dart';
import 'package:mytodo/src/repository/model/todo_model.dart';
import 'package:mytodo/src/repository/todo_repository.dart';

class TodoListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<TodoListView> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'New ToDo',
              onPressed: () {
                TodoRepository().insert(Todo.from(
                    name: 'testName',
                    remarks: 'testRemarks',
                    tag: 'test tag',
                    priority: 0,
                    deadline: DateTime(0),
                    deleted: false,
                    completed: false,
                    completedAt: DateTime(0)));

                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Added!')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(const SnackBar(content: Text('Searched!')));
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
                children:
                    Command.of(CommandType.GET_LATEST_TODO_LIST).execute())
          ],
        ));
  }
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
