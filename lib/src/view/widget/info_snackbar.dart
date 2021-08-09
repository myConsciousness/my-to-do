// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class InfoSnackbar {
  /// The build context
  BuildContext _context;

  /// Returns the new instance of [InfoSnackbar] based on the [context] passed as an argument.
  InfoSnackbar.from(BuildContext context) : this._context = context;

  void show({Key? key, String content = ''}) {
    ScaffoldMessenger.of(this._context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            Icon(Icons.info, color: Colors.blue.shade400),
            SizedBox(width: 10),
            Text(content),
          ],
        ),
      ),
    );
  }
}
