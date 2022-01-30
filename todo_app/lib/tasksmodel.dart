import 'package:hive/hive.dart';
part 'tasksmodel.g.dart';

@HiveType(typeId: 0)
class tasks extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String titledesc;
  @HiveField(2)
  late DateTime deadline;
}
