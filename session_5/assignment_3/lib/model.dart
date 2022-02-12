import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String task;
  @HiveField(1)
  String date;
  Todo(this.task, this.date);
}
