import 'package:hive/hive.dart';

part 'TVShow.g.dart';

@HiveType(typeId: 1)
class TVShows {
  @HiveField(0)
  String title;
  @HiveField(1)
  String imdb;
  @HiveField(2)
  String year;
  @HiveField(3)
  String image;
  @HiveField(4)
  String showId;
  TVShows(
      {required this.title,
      required this.imdb,
      required this.year,
      required this.image,
      required this.showId});
}
