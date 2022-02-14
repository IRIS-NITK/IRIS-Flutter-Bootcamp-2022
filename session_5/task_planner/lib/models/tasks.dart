import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'tasks.g.dart';

@HiveType(typeId: 1)
class Tasks extends HiveObject
{
  @HiveField(0)
  late String task;

  @HiveField(1)
  late String deadline;

  @HiveField(2)
  late double timeleft;
}