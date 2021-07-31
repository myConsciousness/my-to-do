// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobUtils {
  static Widget getBannerAdOrSizedBox(BannerAd? bannerAd) {
    if (bannerAd == null) {
      return CircularProgressIndicator();
    }

    return Container(
      height: 50,
      child: AdWidget(ad: bannerAd),
    );
  }
}
