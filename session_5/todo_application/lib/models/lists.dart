//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/models/tasks.dart';

part 'lists.g.dart';

@HiveType(typeId: 1)
class Lists extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? desc;
  @HiveField(2)
  DateTime? listDate;
  Lists({this.title, this.desc, this.listDate});
}
