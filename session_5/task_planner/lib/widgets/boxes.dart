import 'package:hive/hive.dart';
import 'package:task_planner/models/tasks.dart';

class Boxes
{
  static Box<Tasks> getEntry() => 
      Hive.box<Tasks>('Tasks');
}