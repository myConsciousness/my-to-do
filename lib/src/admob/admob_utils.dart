// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

class AdmobUtils {
  static String getUnitId() {
    return Platform.isAndroid ? 'ca-app-pub-7168775731316469/1821496055' : '';
  }
}
