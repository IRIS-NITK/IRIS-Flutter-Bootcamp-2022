import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc_imdb_movies_app/models/MovieData.dart';

String baseUrl = "https://imdb-api.com/en/API/Top250Movies";
String apiKey = "k_8qu4mv10";
String finalUrl = baseUrl + "/" + apiKey;

class MovieDataRepo {
  Future<List<MovieData>> getMovieData() async {
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    }

    final movieData = json.decode(response.body)["items"];

    List<MovieData> data = [];

    for (var item in movieData) {
      data.add(MovieData(
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
