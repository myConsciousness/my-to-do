// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command_exporter.dart';

class HistoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _Text {
  static const String APP_BAR_TITLE = 'History';

  static const String ACTION_TOOLTIP_SEARCH = 'Search';

  static const String ACTION_TOOLTIP_SORT_ORDER = 'Sort Order';
}

class _State extends State<HistoryView> {
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
      body: Command.of(CommandType.GET_TASK_HISTORY).execute());
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
