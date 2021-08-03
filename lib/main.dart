// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mytodo/src/admob/ad_state.dart';
import 'package:mytodo/src/config/application_text.dart';
import 'package:mytodo/src/view/favorited_task_view.dart';
import 'package:mytodo/src/view/history_view.dart';
import 'package:mytodo/src/view/latest_task_view.dart';
import 'package:provider/provider.dart';

import 'src/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<InitializationStatus> initStatus =
      MobileAds.instance.initialize();
  final AdState adState = AdState.from(initialization: initStatus);

  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyToDo(),
    ),
  );
}

class MyToDo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyToDo> {
  Locale _locale = Locale('en');

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('jp'),
        ],
        locale: this._locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.star)),
                  Tab(icon: Icon(Icons.history)),
                ],
              ),
              title: Text(ApplicationText.APP_NAME),
            ),
            body: TabBarView(
              children: [
                LatestTaskListView(),
                FavoritedTaskListView(),
                HistoryView(),
              ],
            ),
          ),
        ),
      );
}
