import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Tasks {
  @HiveField(0)
  String name;
  @HiveField(1)
  String dt;

  Tasks({
    required this.name,
    required this.dt,
  });
}
