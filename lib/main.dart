// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/config/application_text.dart';
import 'package:mytodo/src/view/history_view.dart';
import 'package:mytodo/src/view/label_view.dart';
import 'package:mytodo/src/view/setting_view.dart';
import 'package:mytodo/src/view/tag_view.dart';
import 'package:mytodo/src/view/todo_list_view.dart';

void main() => runApp(MyToDo());

class MyToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.label)),
                Tab(icon: Icon(Icons.tag)),
                Tab(icon: Icon(Icons.history)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: Text(ApplicationText.APP_NAME),
          ),
          body: TabBarView(
            children: [
              TodoListView(),
              LabelView(),
              TagView(),
              HistoryView(),
              SettingView(),
            ],
          ),
        ),
      ),
    );
  }
}
