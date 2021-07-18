// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class TagView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _Text {
  /// The app bar title
  static const String APP_BAR_TITLE = 'Tag';
}

class _State extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_Text.APP_BAR_TITLE),
      ),
      body: Text('Tag'),
    );
  }
}
