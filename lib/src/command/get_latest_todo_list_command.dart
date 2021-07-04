// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mytodo/src/command/command.dart';

class GetLatestTodoListCommand implements Command {
  /// The constructor.
  GetLatestTodoListCommand.newInstance();

  @override
  List<Widget> execute() {
    return <Widget>[
      Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.black),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
          )),
      Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.black),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
          )),
      Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.black),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          )),
    ];
  }
}
