// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mytodo/src/repository/model/task_model.dart';
import 'package:mytodo/src/repository/repository.dart';

abstract class TaskRepository extends Repository<Task> {
  /// Returns tasks which are not completed and not deleted.
  Future<List<Task>> findNotCompletedAndNotDeleted();

  /// Returns tasks which are favorited and not completed and not deleted.
  Future<List<Task>> findFavoritedAndNotCompletedAndNotDeleted();
}
