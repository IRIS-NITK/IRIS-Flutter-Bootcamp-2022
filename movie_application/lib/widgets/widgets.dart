
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/controllers/cast_controller.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/controllers/search_list_disp_controller.dart';
import 'package:movie_application/screens/details_screen.dart';
import 'package:movie_application/screens/movies_listDisp.dart';
import 'package:movie_application/screens/tvshows_listDisp.dart';

class HomeScreenWidgets {
  TVShowsListDisp tvShowsListDisp = TVShowsListDisp();
  MoviesListDisp moviesListDisp = MoviesListDisp();
  final ListDispController listDispController1 = Get.find();
  final ListDispController listDispController2 = Get.find();
  final SearchListDispController searchListDispController = Get.find();
  final CastController castController = Get.find();

  Widget listCard({int? index, bool movie = true}) {
    return InkWell(
        onTap: () {
          Get.to(DetailsPage(
            index: index,
            movie: movie,
          ));
        },
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.only(
              left: 25.0, right: 25.0, bottom: 10.0, top: 10.0),
          child: (Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Obx(() => Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(movie
                                  ? listDispController2.movieList
                                      .value[int.parse(index.toString())].image
                                      .toString()
                                  : listDispController1.tvShowList
                                      .value[int.parse(index.toString())].image
                                      .toString()))),
                    )),
                Container(
                  width: 20.0,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              movie
                                  ? listDispController2.movieList
                                      .value[int.parse(index.toString())].title
                                      .toString()
                                  : listDispController1.tvShowList
                                      .value[int.parse(index.toString())].title
                                      .toString(),
                              style: const TextStyle(
                                  fontFamily: "Dongle",
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  height: 1),
                            )),
                        Container(
                          height: 20.0,
                        ),
                        Obx(() => Text(
                            movie
                                ? listDispController2
                                    .movieList
                                    .value[int.parse(index.toString())]
                                    .fullTitle
                                    .toString()
                                : listDispController1
                                    .tvShowList
                                    .value[int.parse(index.toString())]
                                    .fullTitle
                                    .toString(),
                            style: const TextStyle(
                                fontFamily: "Dongle",
                                color: Colors.black,
                                fontSize: 25.0,
                                height: 1))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }

  Widget pageCard({int? index, bool movie = true}) {
    return InkWell(
      onTap: () {
        Get.to(DetailsPage(
          index: index,
          movie: movie,
        ));
      },
      child: Container(
        height: 220,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(),
            color: Colors.white),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 140.0,
                child: Obx(() => Image.network(movie
                    ? listDispController2
                        .movieList.value[int.parse(index.toString())].image
                        .toString()
                    : listDispController1
                        .tvShowList.value[int.parse(index.toString())].image
                        .toString())),
              ),
              Container(
                width: 20.0,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        movie
                            ? listDispController2.movieList
                                .value[int.parse(index.toString())].title
                                .toString()
                            : listDispController1.tvShowList
                                .value[int.parse(index.toString())].title
                                .toString(),
                        style: const TextStyle(
                            fontFamily: "Dongle",
                            color: Colors.black,
                            fontSize: 40.0,
                            height: 1),
                      ),
                      Container(
                        height: 30.0,
                      ),
                      Text(
                          movie
                              ? listDispController2.movieList
                                  .value[int.parse(index.toString())].fullTitle
                                  .toString()
                              : listDispController1.tvShowList
                                  .value[int.parse(index.toString())].fullTitle
                                  .toString(),
                          style: const TextStyle(
                              fontFamily: "Dongle",
                              color: Colors.black,
                              fontSize: 30.0,
                              height: 1)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchListCard({int? index, bool movie = true}) {
    return Card(
     margin: const EdgeInsets.only(
              left: 25.0, right: 25.0, bottom: 10.0, top: 10.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Obx(
              () => Container(
                height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movie
                  ? searchListDispController
                      .movieSearchList.value[int.parse(index.toString())].image
                      .toString()
                  : searchListDispController
                      .tvShowSearchList.value[int.parse(index.toString())].image
                      .toString()),
                              fit: BoxFit.cover,)
            ))),
            Container(
              width: 20.0,
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Text(movie
                        ? searchListDispController.movieSearchList
                            .value[int.parse(index.toString())].title
                            .toString()
                        : searchListDispController.tvShowSearchList
                            .value[int.parse(index.toString())].title
                            .toString(),
                            style: const TextStyle(
                                  fontFamily: "Dongle",
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  height: 1))),
                    Container(
                      height: 20.0,
                    ),
                    Obx(() => Text(movie
                        ? searchListDispController.movieSearchList
                            .value[int.parse(index.toString())].fullTitle
                            .toString()
                        : searchListDispController.tvShowSearchList
                            .value[int.parse(index.toString())].fullTitle
                            .toString(),
                            style: const TextStyle(
                                  fontFamily: "Dongle",
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  height: 1))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget castListCard({int? index, String? id}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Obx(()=>Container(
              height: 80,
              width: 50.0,
              margin: const EdgeInsets.only(left: 30.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(castController
                          .castList.value[int.parse(index.toString())].image
                          .toString()))))),
          Container(
            width: 20.0,
          ),
          Expanded(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Expanded(
                      child: Center(
                        child: Text(
                            "${castController.castList.value[int.parse(index.toString())].name.toString()} as ${castController.castList.value[int.parse(index.toString())].asChar.toString()}",
                            style: const TextStyle(fontFamily: "Dongle",
                                      color: Colors.white,
                                      fontSize: 35.0,
                                      height: 1),),
                      ),
                    ))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
