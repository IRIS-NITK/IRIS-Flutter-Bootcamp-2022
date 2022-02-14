import 'package:hive/hive.dart';
import 'task.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box<Task>('tasks');
}
