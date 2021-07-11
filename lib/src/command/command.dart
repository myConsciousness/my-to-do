// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/command/get_favorited_task_list.dart';
import 'package:mytodo/src/command/get_latest_task_list_command.dart';

abstract class Command {
  /// Returns the command instance linked to the [commandType].
  factory Command.of(CommandType commandType) {
    switch (commandType) {
      case CommandType.GET_LATEST_TASK_LIST:
        return GetLatestTaskListCommand.newInstance();
      case CommandType.GET_FAVORITED_TASK_LIST:
        return GetFavoritedTaskListCommand.newInstance();
    }
  }

  /// Executes the command and returns the result.
  dynamic execute();
}

/// The enum class that manages command type.
enum CommandType {
  /// The get latest task list command
  GET_LATEST_TASK_LIST,

  /// The get favorited task list command
  GET_FAVORITED_TASK_LIST
}
