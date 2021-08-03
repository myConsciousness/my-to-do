// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:google_mobile_ads/google_mobile_ads.dart';

/// The class that manages the ad state.
class AdState {
  /// The initialization status
  final Future<InitializationStatus> initialization;

  /// Returns the new instance of [AdState] based on the [initialization].
  AdState.from({required this.initialization});
}
