// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/config/application_text.dart';
import 'package:mytodo/src/view/favorited_task_view.dart';
import 'package:mytodo/src/view/history_view.dart';
import 'package:mytodo/src/view/latest_task_view.dart';

void main() => runApp(MyToDo());

class MyToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.star)),
                  Tab(icon: Icon(Icons.history))
                ],
              ),
              title: Text(ApplicationText.APP_NAME),
            ),
            body: TabBarView(
              children: [
                LatestTaskListView(),
                FavoritedTaskListView(),
                HistoryView()
              ],
            ),
          ),
        ),
      );
}
