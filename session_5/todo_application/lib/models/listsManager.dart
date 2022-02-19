//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/models/lists.dart';

class ListsManager {

  void addList(Lists lists) async {
    var box = await Hive.openBox<Lists>("List Data Maintainer");
    await box.add(lists);
  }

  void deleteList(int key) async {
    var box = await Hive.openBox<Lists>("List Data Maintainer");
    await box.deleteAt(key);
  }

  void editList({required Lists lists, required int key}) async {
    var box = await Hive.openBox<Lists>("List Data Maintainer");
    await box.putAt(key, lists);
  }
}
