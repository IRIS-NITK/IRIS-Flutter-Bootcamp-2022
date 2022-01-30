import 'package:hive/hive.dart';
import 'package:todo_app/tasksmodel.dart';
import 'tasksmodel.dart';

class Boxes {
  static Box<tasks> getTasks() => Hive.box<tasks>("todotasks");
}
