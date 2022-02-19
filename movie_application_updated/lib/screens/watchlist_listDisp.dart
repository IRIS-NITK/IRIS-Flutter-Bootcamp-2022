import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/controllers/watchlist_controller.dart';
import 'package:movie_application/widgets/widgets.dart';

class WatchListDispScreen extends StatefulWidget {
  const WatchListDispScreen({Key? key}) : super(key: key);

  @override
  _WatchListDispScreenState createState() => _WatchListDispScreenState();
}

class _WatchListDispScreenState extends State<WatchListDispScreen> {
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
  final ListDispController listDispController = Get.find();
  final WatchlistDispController watchlistDispController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: const Text("Movies",
                style: TextStyle(fontFamily: "Dongle", fontSize: 60.0)),
          ),
          Obx(() => Container(
              height: 250,
              child: ListView.builder(
                  itemCount:
                      watchlistDispController.movieWatchList.value.length,
                  itemBuilder: (context, index) {
                    return homeScreenWidgets.watchListCard(
                        index: index, movie: true);
                  }))),
          Container(
            height: 30.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: const Text("TV Shows",
                style: TextStyle(fontFamily: "Dongle", fontSize: 60.0)),
          ),
          Container(
              height: 250,
              child: Obx(() => ListView.builder(
                  itemCount:
                      watchlistDispController.tvShowWatchList.value.length,
                  itemBuilder: (context, index) {
                    return homeScreenWidgets.watchListCard(
                        index: index, movie: false);
                  }))),
        ],
      ),
    );
  }
}
