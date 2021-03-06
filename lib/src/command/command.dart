// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/command/get_favorited_task_command.dart';
import 'package:mytodo/src/command/get_latest_task_command.dart';
import 'package:mytodo/src/command/get_task_history_command.dart';

abstract class Command {
  /// Returns the command instance linked to the [commandType].
  factory Command.of(CommandType commandType) {
    switch (commandType) {
      case CommandType.GET_LATEST_TASK:
        return GetLatestTaskCommand.newInstance();
      case CommandType.GET_FAVORITED_TASK:
        return GetFavoritedTaskCommand.newInstance();
      case CommandType.GET_TASK_HISTORY:
        return GetTaskHistoryCommand.newInstance();
    }
  }

  /// Executes the command and returns the result.
  dynamic execute();
}

/// The enum class that manages command type.
enum CommandType {
  /// The get latest task command
  GET_LATEST_TASK,

  /// The get favorited task command
  GET_FAVORITED_TASK,

  /// The get task history command
  GET_TASK_HISTORY
}
