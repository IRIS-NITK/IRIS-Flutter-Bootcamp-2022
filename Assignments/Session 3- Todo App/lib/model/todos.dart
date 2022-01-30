import 'package:hive/hive.dart';
part 'todos.g.dart';

@HiveType(typeId: 1)
class Todo {
  Todo({required this.title, required this.now});

  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime now;
}
