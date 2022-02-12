
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/widgets/widgets.dart';

class WatchlistDispController extends GetxController {
  final ListDispController listDispController = Get.find();
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();

  void watchlistCounter({int? index, bool movie = true}) {
    if (movie
        ? listDispController
                .movieList.value[int.parse(index.toString())].watchlist.value ==
            1
        : listDispController.tvShowList.value[int.parse(index.toString())]
                .watchlist.value ==
            1) {
      movie
          ? listDispController
              .movieList.value[int.parse(index.toString())].watchlist.value--
          : listDispController
              .tvShowList.value[int.parse(index.toString())].watchlist.value--;
      Get.snackbar("Removed from Watchlist",movie
          ? listDispController
              .movieList.value[int.parse(index.toString())].title.toString()
          : listDispController
              .tvShowList.value[int.parse(index.toString())].title.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor:Colors.redAccent);
    } else {
      movie
          ? listDispController
              .movieList.value[int.parse(index.toString())].watchlist.value++
          : listDispController
              .tvShowList.value[int.parse(index.toString())].watchlist.value++;
      Get.snackbar("Added to Watchlist",movie
          ? listDispController
              .movieList.value[int.parse(index.toString())].title.toString()
          : listDispController
              .tvShowList.value[int.parse(index.toString())].title.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor:Colors.green);
    }
  }
}
