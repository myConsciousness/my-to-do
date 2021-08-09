// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:admob_unit_ids/admob_unit_ids.dart';

class MyToDoAdmobUnitIDs extends AdmobUnitIDs {
  /// The singleton instance of [MyToDoAdmobUnitIDs].
  static final MyToDoAdmobUnitIDs _singletonInstance =
      MyToDoAdmobUnitIDs._internal();

  /// The internal default constructor.
  MyToDoAdmobUnitIDs._internal();

  /// Returns the singleton instance of [MyToDoAdmobUnitIDs].
  factory MyToDoAdmobUnitIDs.getInstance() => _singletonInstance;

  @override
  String get releaseAppOpen =>
      Platform.isAndroid ? 'ca-app-pub-7168775731316469/1821496055' : '';

  @override
  String get releaseBanner => throw UnimplementedError();

  @override
  String get releaseInterstitial => throw UnimplementedError();

  @override
  String get releaseInterstitialVideo => throw UnimplementedError();

  @override
  String get releaseNativeAdvanced => throw UnimplementedError();

  @override
  String get releaseNativeAdvancedVideo => throw UnimplementedError();

  @override
  String get releaseRewarded => throw UnimplementedError();

  @override
  String get releaseRewardedInterstitial => throw UnimplementedError();
}
