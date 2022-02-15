import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc_imdb_movies_app/models/TVShowData.dart';

String baseUrl = "https://imdb-api.com/en/API/MostPopularTVs";
String apiKey = "k_8qu4mv10";
String finalUrl = baseUrl + "/" + apiKey;

class TVShowDataRepo {
  Future<List<TVShowData>> getTVShows() async {
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    }

    final tvShowDataJSON = response.body;
    final tvShowData = jsonDecode(tvShowDataJSON)["items"];

    List<TVShowData> data = [];

    for (var item in tvShowData) {
      data.add(TVShowData(
          id: item["id"],
          rank: int.parse(item["rank"]),
          title: item["title"],
          fullTitle: item["fullTitle"],
          crew: item["crew"].split(", "),
          image: item["image"],
          imdbRating: double.parse(item["imdbRating"]),
          imdbRatingCount: int.parse(item["imdbRatingCount"]),
          year: int.parse(item["year"])));
    }

    return data;
  }
}
