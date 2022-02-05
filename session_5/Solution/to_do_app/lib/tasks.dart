
import 'package:hive/hive.dart';

part 'tasks.g.dart';
 
@HiveType(typeId: 0)
class Task{
 
  @HiveField(0)
  String desc;
 
  @HiveField(1)
  String date;
 
  @HiveField(2)
  String time;

  Task({required this.desc,required this.date,required this.time});
 
}