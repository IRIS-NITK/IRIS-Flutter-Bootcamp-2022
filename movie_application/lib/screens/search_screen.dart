
import 'package:flutter/material.dart';
import 'package:movie_application/controllers/search_list_disp_controller.dart';
import 'package:movie_application/widgets/widgets.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  String? input;
  SearchScreen({Key? key, required this.input}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String? inp;

class _SearchScreenState extends State<SearchScreen> {
  HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
  final SearchListDispController searchListDispController = Get.find();

  @override
  void initState() {
    inp = widget.input;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$inp"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text("Movies",
                      style: TextStyle(fontFamily: "Dongle", fontSize: 60.0))),
              Container(
                height: 315.0,
                child: Obx(() =>
                    searchListDispController.movieSearchList.value.isEmpty
                        ? const Center(
                            child: Text("No Match Found!"),
                          )
                        : ListView.builder(
                            itemCount: searchListDispController
                                .movieSearchList.value.length,
                            itemBuilder: (context, index) {
                              return homeScreenWidgets.searchListCard(
                                  index: index, movie: true);
                            })),
              ),
              Container(height: 30.0),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: const Text("TV Shows",
                    style: TextStyle(fontFamily: "Dongle", fontSize: 60.0)),
              ),
              Container(
                height: 315.0,
                child: Obx(() =>
                    searchListDispController.tvShowSearchList.value.isEmpty
                        ? const Center(
                            child: Text("No Match Found!"),
                          )
                        : ListView.builder(
                            itemCount: searchListDispController
                                .tvShowSearchList.value.length,
                            itemBuilder: (context, index) {
                              return homeScreenWidgets.searchListCard(
                                  index: index, movie: false);
                            })),
              ),
            ],
          ),
        ));
  }
}
