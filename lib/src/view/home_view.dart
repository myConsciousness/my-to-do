// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/config/application_text.dart';
import 'package:mytodo/src/view/common/drawer_view.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApplicationText.APP_NAME),
      ),
      drawer: CommonDrawer(),
      body: Text('Test'),
    );
  }
}
