import 'package:hive/hive.dart';

part 'task.g.dart';


@HiveType(typeId:0)
class Task extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime deadline;

  @HiveField(3)
  late bool? notify;


}