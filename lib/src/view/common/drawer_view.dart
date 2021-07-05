// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/config/application_text.dart';
import 'package:mytodo/src/view/history_view.dart';
import 'package:mytodo/src/view/home_view.dart';
import 'package:mytodo/src/view/label_view.dart';
import 'package:mytodo/src/view/setting_view.dart';

class CommonDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CommonDrawer> {
  /// The title of home
  static const String _TITLE_HOME = 'Home';

  /// The title of history
  static const String _TITLE_HISTORY = 'History';

  /// The title of label
  static const String _TITLE_LABEL = 'Label';

  /// The title of setting
  static const String _TITLE_SETTING = 'Setting';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              ApplicationText.APP_NAME,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(_TITLE_HOME),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ));
            },
          ),
          ListTile(
            title: Text(_TITLE_HISTORY),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryView()));
            },
          ),
          ListTile(
            title: Text(_TITLE_LABEL),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LabelView()));
            },
          ),
          ListTile(
            title: Text(_TITLE_SETTING),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingView()));
            },
          ),
        ],
      ),
    );
  }
}
