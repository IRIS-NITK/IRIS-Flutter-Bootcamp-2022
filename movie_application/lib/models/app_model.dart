
import 'package:get/get.dart';

class AppModel extends GetxController {
  String? id;
  String? title;
  String? fullTitle;
  int? year;
  String? image;
  double? imDbRating;
  int? iMDbRatingCount;
  var watchlist = 0.obs;

  AppModel(
      {this.id,
      this.title,
      this.fullTitle,
      this.year,
      this.image,
      this.imDbRating,
      this.iMDbRatingCount,
      required this.watchlist});
}
