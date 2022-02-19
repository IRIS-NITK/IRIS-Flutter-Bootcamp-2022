import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/api_key.dart';


// Popular Movies API ==================================================================

class PopularMovies{
  final String id;
  final String title;
  final Image image;

  PopularMovies(this.id, this.title, this.image);
}



  

Future<List> getPopularMovies() async{

  List<PopularMovies> popularMovies = [];

  Uri? url = Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/$apiKey');
  var response = await http.get(url);
  var body = jsonDecode(response.body);

  var movies = body["items"];

  for(int i = 0; i < 10; i++) {
    popularMovies.add(PopularMovies(movies[i]["id"], movies[i]["title"], Image.network(movies[i]["image"])));

  }

  return popularMovies;

}
// ============================================================================================================




// Popular TVs API ==================================================================

class PopularTvs{
  final String id;
  final String title;
  final Image image;

  PopularTvs(this.id, this.title, this.image);
}



  

Future<List> getPopularTvs() async{

  List<PopularMovies> popularTvs = [];

  Uri? url = Uri.parse('https://imdb-api.com/en/API/MostPopularTVs/$apiKey');
  var response = await http.get(url);
  var body = jsonDecode(response.body);

  var shows = body["items"];

  for(int i = 0; i < 10; i++) {
    popularTvs.add(PopularMovies(shows[i]["id"], shows[i]["title"], Image.network(shows[i]["image"])));

  }

  return popularTvs;

}
// ============================================================================================================



// Top 10 Movies API ==================================================================

class Top10Movies{
  final String id;
  final String title;
  final Image image;

  Top10Movies(this.id, this.title, this.image);
}



  

Future<List> getTop10Movies() async{

  List<PopularMovies> top10Movies = [];

  Uri? url = Uri.parse('https://imdb-api.com/en/API/Top250Movies/$apiKey');
  var response = await http.get(url);
  var body = jsonDecode(response.body);

  var shows = body["items"];

  for(int i = 0; i < 10; i++) {
    top10Movies.add(PopularMovies(shows[i]["id"], shows[i]["title"], Image.network(shows[i]["image"])));

  }

  return top10Movies;

}
// ============================================================================================================




