import 'package:hive/hive.dart';
part 'todo_adapter.g.dart';

//code to be typed in terminal to generate .g.dart file after writing above part statement
//flutter packages pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  bool completionStatus;
  Todo(
      {required this.title,
      required this.description,
      required this.dateTime,
      required this.completionStatus});
}
