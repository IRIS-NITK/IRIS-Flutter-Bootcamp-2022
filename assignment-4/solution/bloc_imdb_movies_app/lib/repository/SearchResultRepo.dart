import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc_imdb_movies_app/models/SearchResult.dart';

String baseUrl = "https://imdb-api.com/en/API/Search";
String apiKey = "k_8qu4mv10";

class SearchResultRepo {
  Future<List<SearchResult>> getSearchResults(String query) async {
    try {
      String finalUrl = baseUrl + "/" + apiKey + "/" + query;
      final response = await http.get(Uri.parse(finalUrl));

      if (response.statusCode != 200) {
        throw Exception("Sorry, there was a problem");
      } 
      else {
        final body = response.body;
        final searchResults = jsonDecode(body)["results"];

      List<SearchResult> data = [];

        for (var item in searchResults) {
          data.add(SearchResult(
              id: item["id"],
              description: item["description"],
              image: item["image"],
              resultType: item["resultType"],
              title: item["title"]));
        }

        return data;
      }
    } catch (_) {
      throw Exception("Please check your internet connection");
    }
  }
}
