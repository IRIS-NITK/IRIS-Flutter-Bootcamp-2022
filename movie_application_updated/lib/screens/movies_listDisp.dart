
import 'package:flutter/material.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/widgets/widgets.dart';
import 'package:get/get.dart';

class MoviesListDisp extends StatefulWidget {
  const MoviesListDisp({Key? key}) : super(key: key);

  @override
  _MoviesListDispState createState() => _MoviesListDispState();
}

class _MoviesListDispState extends State<MoviesListDisp> {
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
  final ListDispController listDispController2 = Get.find();

  @override
  void initState() {
    listDispController2.setMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20.0,
          ),
          child: const Text(
            "Top 5 Picks",
            style: TextStyle(fontFamily: "Dongle", fontSize: 60.0),
          ),
        ),
        Container(
            child: Obx(() => listDispController2.movieList.value.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    height: 220,
                    width: 430,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.88),
                        itemCount: listDispController2.movieList.value.length -
                            listDispController2.movieList.value.length +
                            5,
                        itemBuilder: (context, index) {
                          return homeScreenWidgets.pageCard(
                              index: index, movie: true);
                        }),
                  ))),
        Container(
          height: 30.0,
        ),Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "All Time Hits",
                    style: TextStyle(
                      fontFamily: "Dongle",
                      fontSize: 60.0,
                    ),
                  ),
                ),
        Obx(() => Container(
          height: 350,
          child: listDispController2.movieList.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
              itemCount: listDispController2.movieList.value.length - 5,
              itemBuilder: (context, index) {
                return homeScreenWidgets.listCard(index: index + 5, movie: true);
              }),
        )),
      ]),
    );
  }
}
