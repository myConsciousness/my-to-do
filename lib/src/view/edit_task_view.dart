// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/src/config/priority.dart';
import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/service/task_service.dart';
import 'package:mytodo/src/view/widget/tags_styler.dart';
import 'package:mytodo/src/view/widget/text_field_style.dart';
import 'package:mytodo/src/view/widget/text_field_tags.dart';

class EditTaskView extends StatefulWidget {
  /// The task to be edited
  final Task _task;

  EditTaskView(Task task) : this._task = task;

  @override
  State<StatefulWidget> createState() {
    return _State(this._task);
  }
}

class _Text {
  static const String APP_BAR_TITLE = 'Edit Task';

  static const String ACTION_TOOLTIP_DONE = 'Done';
}

class _State extends State<EditTaskView> {
  /// The task to be edited
  final Task _task;

  _State(Task task) : this._task = task;

  /// The max length of task name
  static const int _MAX_LENGTH_TASK_NAME = 20;

  /// The max length of remarks
  static const int _MAX_LENGTH_REMARKS = 100;

  /// The max length of tag
  static const int _MAX_LENGTH_TAG = 15;

  final DateTime _now = DateTime.now();
  final DateFormat _dateFormat = new DateFormat('yyyy/MM/dd');
  final DateFormat _timeFormat = new DateFormat('HH:mm');

  bool _dateSelected = false;
  String _selectedDateStr = '';
  String _selectedTimeStr = '';
  DateTime _selectedDate = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _selectedTime = DateTime.fromMillisecondsSinceEpoch(0);

  List<String> _tags = <String>[];

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Priority _priority = Priority.LOW;

  @override
  void initState() {
    super.initState();

    this._taskNameController.text = this._task.name;
    this._remarksController.text = this._task.remarks;
    this._tags = this._task.tags;
    this._dateSelected = this._task.hasDeadline;
    this._selectedDateStr = this._task.hasDeadline
        ? this._dateFormat.format(this._task.deadline)
        : '';
    this._selectedTimeStr = this._task.hasDeadline
        ? this._timeFormat.format(this._task.deadline)
        : '';
    this._priority = this._task.priority;

    this._taskNameController.addListener(() => super.setState(() {
          this._taskNameController.text;
        }));
    this._remarksController.addListener(() => super.setState(() {
          this._remarksController.text;
        }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(_Text.APP_BAR_TITLE), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.check),
          tooltip: _Text.ACTION_TOOLTIP_DONE,
          onPressed: () {
            TaskService.getInstance().update(Task.from(
                id: this._task.id,
                name: this._taskNameController.text,
                remarks: this._remarksController.text,
                tags: this._tags,
                priority: this._priority,
                hasDeadline: this._dateSelected,
                deadline: DateTime(
                    this._selectedDate.year,
                    this._selectedDate.month,
                    this._selectedDate.day,
                    this._selectedTime.hour,
                    this._selectedTime.minute),
                createdAt: this._task.createdAt,
                updatedAt: DateTime.now()));

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Updated Task!')));
          },
        ),
      ]),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Task',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  )),
              TextField(
                maxLength: _MAX_LENGTH_TASK_NAME,
                controller: this._taskNameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.task),
                  labelText: "Task Name",
                  hintText: "New task name",
                  counterText:
                      "${_MAX_LENGTH_TASK_NAME - this._taskNameController.text.length} / $_MAX_LENGTH_TASK_NAME",
                ),
              ),
              SizedBox(height: 2),
              TextField(
                maxLength: _MAX_LENGTH_REMARKS,
                controller: this._remarksController,
                decoration: InputDecoration(
                  icon: Icon(Icons.note),
                  labelText: "Remarks",
                  hintText: "About task",
                  counterText:
                      "${_MAX_LENGTH_REMARKS - this._remarksController.text.length} / $_MAX_LENGTH_REMARKS",
                ),
              ),
              SizedBox(height: 15),
              Text('Tags',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 8),
              Flexible(
                  child: TextFieldTags(
                initialTags: this._task.tags,
                textFieldStyler: TextFieldStyler(icon: Icon(Icons.tag)),
                tagsStyler: TagsStyler(),
                validator: (String? tag) {
                  if (tag!.length > _MAX_LENGTH_TAG) {
                    return "The tag must less than $_MAX_LENGTH_TAG characters";
                  }
                },
                onTag: (String tag) {
                  this._tags.add(tag);
                },
                onDelete: (String tag) {
                  this._tags.remove(tag);
                },
              )),
              SizedBox(
                height: 40,
              ),
              Text('Deadline',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: this._selectedDateStr),
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: "Date",
                        hintText: "Select date"),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: this._now,
                          maxTime: this._now.add(const Duration(days: 365 * 5)),
                          onConfirm: (date) {
                        this._dateSelected = true;
                        this._selectedDate = date;

                        super.setState(() {
                          this._selectedDateStr = this._dateFormat.format(date);
                        });
                      }, currentTime: this._now, locale: LocaleType.en);
                    },
                  )),
                  SizedBox(width: 20),
                  Flexible(
                      child: TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: this._selectedTimeStr),
                    decoration: InputDecoration(
                        icon: Icon(Icons.watch),
                        labelText: "Time",
                        hintText: "Select time"),
                    onTap: () {
                      DatePicker.showTimePicker(context, showTitleActions: true,
                          onConfirm: (DateTime time) {
                        this._selectedTime = time;

                        super.setState(() {
                          this._selectedTimeStr = this._timeFormat.format(time);
                        });
                      }, currentTime: this._now, locale: LocaleType.en);
                    },
                  )),
                ],
              ),
              SizedBox(height: 45),
              Text('Priority',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: RadioListTile<Priority>(
                    title: const Text('Low'),
                    value: Priority.LOW,
                    groupValue: this._priority,
                    onChanged: (Priority? value) {
                      setState(() {
                        this._priority = value!;
                      });
                    },
                  )),
                  Flexible(
                      child: RadioListTile<Priority>(
                    title: const Text('High'),
                    value: Priority.HIGH,
                    groupValue: this._priority,
                    onChanged: (Priority? value) {
                      setState(() {
                        this._priority = value!;
                      });
                    },
                  )),
                ],
              ),
            ],
          )));
}
