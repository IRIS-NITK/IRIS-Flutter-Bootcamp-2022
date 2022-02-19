
import 'package:flutter/material.dart';
import 'package:movie_application/controllers/cast_controller.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/controllers/watchlist_controller.dart';
import 'package:get/get.dart';
import 'package:movie_application/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  int? index;
  bool movie;
  DetailsPage({
    Key? key,
    required this.index,
    required this.movie,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

int? ind;
bool mov = true;

class _DetailsPageState extends State<DetailsPage> {
  final WatchlistDispController watchlistDispController = Get.find();
  final ListDispController listDispController = Get.find();
  final CastController castController = Get.find();
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();

  @override
  void initState() {
    ind = widget.index;
    mov = widget.movie;
    castController.castList.value.clear();
    castController.setCastList(
        id: mov
            ? listDispController.movieList.value[int.parse(ind.toString())].id
                .toString()
            : listDispController.tvShowList.value[int.parse(ind.toString())].id
                .toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            mov
                ? listDispController
                    .movieList.value[int.parse(ind.toString())].title
                    .toString()
                : listDispController
                    .tvShowList.value[int.parse(ind.toString())].title
                    .toString(),
            style: const TextStyle(
                fontFamily: "Dongle",
                fontSize: 40.0))), //appRepo.listMovie[ind]["title"]),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          mov
              ? watchlistDispController.watchlistCounter(index: ind)
              : watchlistDispController.watchlistCounter(
                  index: ind, movie: false);
        },
        child: const Icon(Icons.favorite),
        tooltip: "Add To WatchList",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30.0,
            ),
            Container(
              height: 250,
              width: 250,
              child: Obx(() => Image.network(mov
                  ? listDispController
                      .movieList.value[int.parse(ind.toString())].image
                      .toString()
                  : listDispController
                      .tvShowList.value[int.parse(ind.toString())].image
                      .toString())),
            ),
            Container(
              height: 40.0,
            ),
            Container(
              child: Obx(() => Text(
                  "Description: ${mov ? listDispController.movieList.value[int.parse(ind.toString())].fullTitle.toString() : listDispController.tvShowList.value[int.parse(ind.toString())].fullTitle.toString()}",
                  style: const TextStyle(fontFamily: "Dongle", fontSize: 33.0))),
            ),
            Container(
              height: 30.0,
            ),
            Container(
              child: const Text("Cast:",style: TextStyle(fontFamily: "Dongle", fontSize: 33.0,height: 1)),
            ),
            Obx(
              () => Container(
                  height: 100,
                  child: castController.castList.value.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PageView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: castController.castList.value.length,
                          itemBuilder: (context, index) {
                            return homeScreenWidgets.castListCard(
                                index: index,
                                id: mov
                                    ? listDispController.movieList
                                        .value[int.parse(ind.toString())].id
                                    : listDispController.tvShowList
                                        .value[int.parse(ind.toString())].id);
                          })),
            ),
            Container(
              height: 30,
            ),
            Container(
                child: Text(
                    "IMDb Rating: ${mov ? listDispController.movieList.value[int.parse(ind.toString())].imDbRating.toString() : listDispController.movieList.value[int.parse(ind.toString())].imDbRating.toString()}",style: TextStyle(fontFamily: "Dongle", fontSize: 33.0))),
            
            Container(
                child: Text(
                    "IMDb Rating Count: ${mov ? listDispController.movieList.value[int.parse(ind.toString())].iMDbRatingCount : listDispController.movieList.value[int.parse(ind.toString())].iMDbRatingCount}",style: TextStyle(fontFamily: "Dongle", fontSize: 33.0))),
            Container(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                onPressed: () {
                  listDispController.onPressYouTube(
                      id: mov
                          ? listDispController
                              .movieList.value[int.parse(ind.toString())].id
                          : listDispController
                              .tvShowList.value[int.parse(ind.toString())].id);
                },
                child: const Text("YouTube Link",style: TextStyle(fontFamily: "Dongle", fontSize: 25.0))),
            Container(
              height: 10.0,
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                onPressed: () {
                  listDispController.onPressWiki(
                      id: mov
                          ? listDispController
                              .movieList.value[int.parse(ind.toString())].id
                          : listDispController
                              .tvShowList.value[int.parse(ind.toString())].id);
                },
                child: const Text("Wikipedia Link",style: TextStyle(fontFamily: "Dongle", fontSize: 25.0)))
          ],
        ),
      ),
    );
  }
}
