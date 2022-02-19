
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/models/app_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application/screens/search_screen.dart';

class SearchListDispController extends GetxController {
  var movieSearchList = RxList<AppModel>().obs;
  var tvShowSearchList = RxList<AppModel>().obs;
  var searchController = TextEditingController();

  void onPressSearch(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Search",
              style: TextStyle(fontFamily: "Dongle", fontSize: 40),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text("What are you looking for?",
                        style: TextStyle(fontFamily: "Dongle", fontSize: 30)),
                    hintText: "Enter search keyword...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  keyboardType: TextInputType.name,
                  controller: searchController,
                ),
                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                    onPressed: () {
                      setMovieSearch(xy: searchController.text);
                      setTVSearch(xy: searchController.text);
                      Get.to(SearchScreen(input: searchController.text));
                      searchController.text = '';
                    },
                    child: const Text("Search",style: TextStyle(fontFamily: "Dongle", fontSize: 25.0)))
              ],
            ),
          );
        });
  }

  void setMovieSearch({String xy = ""}) async {
    String url = "https://imdb-api.com/en/API/SearchMovie/k_mrk8davb/" + xy;
    var response = await http.get(Uri.parse(url));
    var mapResponse;
    var listSearchMovie;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapResponse = jsonDecode(response.body);
      listSearchMovie = mapResponse["results"].toList();
    }

    movieSearchList.value.clear();
    for (int i = 0; i < listSearchMovie.length; i++) {
      AppModel appModel = AppModel(
          id: listSearchMovie[i]["id"],
          image: listSearchMovie[i]["image"],
          title: listSearchMovie[i]["title"],
          fullTitle: listSearchMovie[i]["title"] +
              " " +
              listSearchMovie[i]["description"],
          watchlist: 0.obs);
      movieSearchList.value.add(appModel);
    }
  }

  void setTVSearch({String xy = ""}) async {
    String url = "https://imdb-api.com/en/API/SearchSeries/k_mrk8davb/${xy}";
    var response = await http.get(Uri.parse(url));
    var mapResponse;
    var listSearchTVShow;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapResponse = jsonDecode(response.body);
      listSearchTVShow = mapResponse["results"].toList();
    }

    tvShowSearchList.value.clear();
    for (int i = 0; i < listSearchTVShow.length; i++) {
      AppModel appModel = AppModel(
          id: listSearchTVShow[i]["id"],
          image: listSearchTVShow[i]["image"],
          title: listSearchTVShow[i]["title"],
          fullTitle: listSearchTVShow[i]["title"] +
              " " +
              listSearchTVShow[i]["description"],
          watchlist: 0.obs);
      tvShowSearchList.value.add(appModel);
    }
  }
}
