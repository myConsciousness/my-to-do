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
            title: Text('Home'),
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
            title: Text('History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryView()));
            },
          ),
          ListTile(
            title: Text('Label'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LabelView()));
            },
          ),
          ListTile(
            title: Text('Setting'),
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
