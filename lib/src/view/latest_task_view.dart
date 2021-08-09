// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/src/admob/admob_utils.dart';
import 'package:mytodo/src/config/priority.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';
import 'package:mytodo/src/view/add_new_task_view.dart';
import 'package:mytodo/src/view/edit_task_view.dart';
import 'package:mytodo/src/view/widget/info_snackbar.dart';

class LatestTaskListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<LatestTaskListView> {
  final TaskService _taskService = TaskService.getInstance();

  final DateFormat _datetimeFormat = DateFormat('yyyy/MM/dd HH:mm');

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
          title: Text('Task'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'New Task',
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddNewTaskView()))
                    .then((_) => super.setState(() {}));
              },
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: this._taskService.findNotCompletedAndNotDeleted(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  leading: Icon(this._getPriorityIcon(task.priority)),
                  title: Text(task.name),
                  subtitle: Text(task.remarks),
                )),
                TextButton(
                  child: Icon(task.favorited ? Icons.star : Icons.star_border),
                  onPressed: () {
                    task.favorited = !task.favorited;

                    super.setState(() {
                      this._taskService.update(task);
                    });
                  },
                ),
                SizedBox(width: 7),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 72,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.schedule,
                              size: 12,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              task.hasDeadline
                                  ? this._datetimeFormat.format(task.deadline)
                                  : '',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.tag,
                              size: 12,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              task.tags.isNotEmpty ? task.tags.join(' ') : '',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTaskView(task)))
                            .then((value) => super.setState(() {}));
                      },
                    ),
                    const SizedBox(width: 7),
                    TextButton(
                      child: const Icon(Icons.done),
                      onPressed: () {
                        task.completed = true;

                        super.setState(() {
                          TaskService.getInstance().update(task);
                        });

                        InfoSnackbar.from(context).show(content: 'Completed!');
                      },
                    ),
                    const SizedBox(width: 7),
                    TextButton(
                      child: const Icon(Icons.delete),
                      onPressed: () {
                        task.deleted = true;

                        super.setState(() {
                          TaskService.getInstance().update(task);
                        });

                        InfoSnackbar.from(context).show(content: 'Deleted!');
                      },
                    ),
                    const SizedBox(width: 7),
                  ],
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

  IconData _getPriorityIcon(Priority? priority) =>
      priority == Priority.LOW ? Icons.low_priority : Icons.priority_high;
}
