import 'package:hive/hive.dart';
import 'package:todo_application/models/task.dart';

class Boxes {
  static Box<Task> getTask() =>
    Hive.box<Task>('tasks');
}