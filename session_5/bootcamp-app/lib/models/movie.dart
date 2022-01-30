import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movies {
  @HiveField(0)
  String title;
  @HiveField(1)
  String imdb;
  @HiveField(2)
  String year;
  @HiveField(3)
  String image;
  @HiveField(4)
  String movieId;
  Movies(
      {required this.title,
      required this.imdb,
      required this.year,
      required this.image,
      required this.movieId});
}
