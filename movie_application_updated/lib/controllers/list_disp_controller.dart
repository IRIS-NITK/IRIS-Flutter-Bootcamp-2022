import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:movie_application/models/app_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ListDispController extends GetxController {
  var movieList = RxList<AppModel>().obs;
  var tvShowList = RxList<AppModel>().obs;

  void setMovies() async {
    String url = "https://imdb-api.com/en/API/Top250Movies/k_mrk8davb";
    var response = await http.get(Uri.parse(url));
    var mapMovie;
    var listMovie;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapMovie = jsonDecode(response.body);
      listMovie = mapMovie["items"].toList();
    }

    for (int i = 0; i < listMovie.length; i++) {
      AppModel appModel = AppModel(
          id: listMovie[i]["id"],
          rank: int.parse(listMovie[i]["rank"]),
          title: listMovie[i]["title"],
          fullTitle: listMovie[i]["fullTitle"],
          year: int.parse(listMovie[i]["year"]),
          image: listMovie[i]["image"],
          imDbRating: double.parse(listMovie[i]["imDbRating"]),
          iMDbRatingCount: int.parse(listMovie[i]["imDbRatingCount"]),
          watchlist: 0.obs);
      movieList.value.add(appModel);
    }
  }

  void setTV() async {
    String url = "https://imdb-api.com/en/API/Top250TVs/k_mrk8davb";
    var response = await http.get(Uri.parse(url));
    var mapTVShow;
    var listTVShow;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapTVShow = jsonDecode(response.body);
      listTVShow = mapTVShow["items"].toList();
    }

    for (int i = 0; i < listTVShow.length; i++) {
      AppModel appModel = AppModel(
          id: listTVShow[i]["id"],
          rank: int.parse(listTVShow[i]["rank"]),
          title: listTVShow[i]["title"],
          fullTitle: listTVShow[i]["fullTitle"],
          year: int.parse(listTVShow[i]["year"]),
          image: listTVShow[i]["image"],
          imDbRating: double.parse(listTVShow[i]["imDbRating"]),
          iMDbRatingCount: int.parse(listTVShow[i]["imDbRatingCount"]),
          watchlist: 0.obs);
      tvShowList.value.add(appModel);
    }
  }

  void onPressYouTube({String? id}) async {
    print("YT - ${id}");
    String url =
        "https://imdb-api.com/en/API/YouTubeTrailer/k_mrk8davb/${id.toString()}";
    var response = await http.get(Uri.parse(url));
    var mapResponse;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapResponse = jsonDecode(response.body);
      _launchURL(mapResponse["videoUrl"]);
    }
  }

  void onPressWiki({String? id}) async {
    print("Wiki - ${id}");
    String url =
        "https://imdb-api.com/en/API/Wikipedia/k_mrk8davb/${id.toString()}";
    var response = await http.get(Uri.parse(url));
    var mapResponse;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapResponse = jsonDecode(response.body);
      _launchURL(mapResponse["url"]);
    }
  }

  void _launchURL(String? _url) async {
    if (!await launch(_url.toString())) throw 'Could not launch $_url';
  }

  @override
  void onInit() {
    setMovies();
    setTV();
    super.onInit();
  }
}
