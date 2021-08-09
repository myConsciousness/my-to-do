// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mytodo/src/admob/ad_unit_id.dart';

class AdmobUtils {
  static Widget createBannerAdWidget(BannerAd bannerAd) => Container(
        height: 50,
        child: AdWidget(ad: bannerAd),
      );

  static BannerAd loadBannerAd() => BannerAd(
        size: AdSize.banner,
        adUnitId: MyToDoAdmobUnitIDs.getInstance().banner,
        listener: BannerAdListener(),
        request: AdRequest(),
      )..load();
}
