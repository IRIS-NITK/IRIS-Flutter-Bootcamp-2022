import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks {
  @HiveField(0)
  String task;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  DateTime time;
  Tasks({required this.task, required this.date, required this.time});
}
