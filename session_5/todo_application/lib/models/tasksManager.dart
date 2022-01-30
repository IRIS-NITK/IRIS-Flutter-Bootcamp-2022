//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/models/tasks.dart';

class TasksManager {

  static void addTask(Tasks tasks) async {
    var box = await Hive.openBox<Tasks>("Task Data Maintainer");
    await box.add(tasks);
  }

  static void deleteTask(int key) async {
    var box = await Hive.openBox<Tasks>("Task Data Maintainer");
    await box.deleteAt(key);
  }

  static void editTask({required Tasks tasks, required int key}) async {
    var box = await Hive.openBox<Tasks>("Task Data Maintainer");
    await box.putAt(key, tasks);
  }
}
