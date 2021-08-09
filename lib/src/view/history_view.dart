// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mytodo/src/admob/admob_utils.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';
import 'package:mytodo/src/view/widget/info_snackbar.dart';

class HistoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HistoryView> {
  final List<BannerAd> _bannerAds = <BannerAd>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    for (BannerAd bannerAd in this._bannerAds) {
      bannerAd.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('History'),
        ),
        body: Container(
          child: FutureBuilder(
            future: TaskService.getInstance().findCompletedOrDeleted(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              context.findAncestorStateOfType();
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index != 0 && index % 2 == 0) {
                    return Column(
                      children: [
                        AdmobUtils.createBannerAdWidget(this._loadBannerAd()),
                        this._buildTaskCard(
                            context, index, snapshot.data[index])
                      ],
                    );
                  }

                  return this
                      ._buildTaskCard(context, index, snapshot.data[index]);
                },
              );
            },
          ),
        ),
      );

  Card _buildTaskCard(BuildContext context, int index, Task task) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(this._getHistoryIcon(task)),
              title: Text(task.name),
              subtitle: Text(task.remarks),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Icon(Icons.undo),
                  onPressed: () {
                    if (task.completed) {
                      task.completed = false;
                    } else {
                      task.deleted = false;
                    }

                    super.setState(() {
                      TaskService.getInstance().update(task);
                    });

                    InfoSnackbar.from(context).show(content: 'Undo Task!');
                  },
                ),
                TextButton(
                  child: const Icon(Icons.delete_forever),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Task'),
                          content: Text(
                              'Delete this task data. Once the data is deleted, it cannot be restored. Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                super.setState(() {
                                  TaskService.getInstance().delete(task);
                                });

                                InfoSnackbar.from(context)
                                    .show(content: 'Deleted Task!');

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      );

  BannerAd _loadBannerAd() {
    final BannerAd bannerAd = AdmobUtils.loadBannerAd();
    this._bannerAds.add(bannerAd);
    return bannerAd;
  }

  IconData _getHistoryIcon(Task task) =>
      task.completed ? Icons.done : Icons.delete;
}
