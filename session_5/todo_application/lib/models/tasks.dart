//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tasks.g.dart';

@HiveType(typeId: 2)
class Tasks extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  bool? isDone;
  @HiveField(2)
  int? listIndex;
  Tasks({this.title, this.isDone,this.listIndex});
}
