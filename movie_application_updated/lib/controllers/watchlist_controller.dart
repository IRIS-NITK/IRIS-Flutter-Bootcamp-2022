import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/models/app_model.dart';
import 'package:movie_application/widgets/widgets.dart';

class WatchlistDispController extends GetxController {
  final ListDispController listDispController = Get.find();
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();

  var movieWatchList = RxList<AppModel>().obs;
  var tvShowWatchList = RxList<AppModel>().obs;

  void updateWatchList() {
    movieWatchList.value.clear();
    tvShowWatchList.value.clear();

    for (int i = 0; i < listDispController.movieList.value.length; i++) {
      if (listDispController.movieList.value[i].watchlist.value == 1) {
        movieWatchList.value.add(listDispController.movieList.value[i]);
      }
    }

    for (int i = 0; i < listDispController.tvShowList.value.length; i++) {
      if (listDispController.tvShowList.value[i].watchlist.value == 1) {
        tvShowWatchList.value.add(listDispController.tvShowList.value[i]);
      }
    }
  }

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
      Get.snackbar(
          "Removed from Watchlist",
          movie
              ? listDispController
                  .movieList.value[int.parse(index.toString())].title
                  .toString()
              : listDispController
                  .tvShowList.value[int.parse(index.toString())].title
                  .toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    } else {
      movie
          ? listDispController
              .movieList.value[int.parse(index.toString())].watchlist.value++
          : listDispController
              .tvShowList.value[int.parse(index.toString())].watchlist.value++;
      Get.snackbar(
          "Added to Watchlist",
          movie
              ? listDispController
                  .movieList.value[int.parse(index.toString())].title
                  .toString()
              : listDispController
                  .tvShowList.value[int.parse(index.toString())].title
                  .toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green);
    }
    updateWatchList();
  }
}
