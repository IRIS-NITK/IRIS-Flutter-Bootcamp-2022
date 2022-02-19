import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/controllers/cast_controller.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/controllers/search_list_disp_controller.dart';
import 'package:movie_application/controllers/watchlist_controller.dart';
import 'package:movie_application/screens/home_screen.dart';
import 'package:movie_application/Themes/themes.dart';

void main() async {
  final ListDispController listDispController = Get.put(ListDispController());
  final SearchListDispController searchListDispController =
      Get.put(SearchListDispController());
  final CastController castController = Get.put(CastController());
  final WatchlistDispController watchlistDispController =
      Get.put(WatchlistDispController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Movies and TV Shows Application",
    home: const DefaultTabController(
      length: 3,
      child: HomeScreen(),
    ),
    theme: Themes.light,
    darkTheme: Themes.dark,
  ));
}
