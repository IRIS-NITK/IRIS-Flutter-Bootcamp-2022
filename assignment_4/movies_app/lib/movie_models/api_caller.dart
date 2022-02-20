import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/movie_models/movie.dart';

class ApiCaller{
  ApiCaller(this.API_KEY);

  final String API_KEY;

  Future<List<Movie>> getTop250Movies(String repo) async{
    final response = await http.get(
      Uri.parse("$repo/$API_KEY")
    );

    final movies = jsonDecode(response.body)["items"];

    List<Movie> movieList = [];
    for(Map<String, dynamic> x in movies){
      movieList.add(Movie(x["id"], x["title"], x["year"], x["image"], x["imDbRating"]));
    }

    return movieList;
  }

  Future<List<TVShow>> getTop250TVs(String repo) async{

    final response = await http.get(
        Uri.parse("$repo/$API_KEY")
    );

    final shows = jsonDecode(response.body)["items"];

    List<TVShow> showList = [];
    for(Map<String, dynamic> x in shows){
      showList.add(TVShow(x["id"], x["title"], x["year"], x["image"], x["imDbRating"], x["crew"]));
    }

    return showList;
  }

  Future<MovieCast> getMovieCast(String repo, Movie movie) async{
    final response = await http.get(
      Uri.parse("$repo/$API_KEY/${movie.id}")
    );

    final cast = jsonDecode(response.body);

    MovieCast casts = MovieCast(cast["actors"], cast["directors"]["items"], cast["writers"]["items"], movie);

    return casts;
  }

  Future<ShowCast> getTVCast(String repo, TVShow show) async{
    final response = await http.get(
        Uri.parse("$repo/$API_KEY/${show.id}")
    );

    final cast = jsonDecode(response.body);

    ShowCast casts = ShowCast(cast["actors"], cast["directors"]["items"], cast["writers"]["items"], show);

    return casts;
  }

  Future<List<Movie>> searchMovies(String repo, String expression) async{

    final response = await http.get(
        Uri.parse("$repo/$API_KEY/$expression")
    );

    final  movies = jsonDecode(response.body)["results"];

    List<Movie> movieList = [];
    for(Map<String, dynamic> x in movies){
      final ratingresponse = await http.get(
        Uri.parse("https://imdb-api.com/en/API/Ratings/$API_KEY/${x["id"]}")
      );
      final ratings = jsonDecode(ratingresponse.body);
      movieList.add(Movie(x["id"], x["title"], x["description"], x["image"], ratings["imDb"]));
    }

    return movieList;
  }

  Future<List<TVShow>> searchTVshows(String repo, String expression) async{

    final response = await http.get(
        Uri.parse("$repo/$API_KEY/$expression")
    );

    final shows = jsonDecode(response.body)["results"];

    List<TVShow> showList = [];
    for(Map<String, dynamic> x in shows){
      final ratingresponse = await http.get(
          Uri.parse("https://imdb-api.com/en/API/Ratings/$API_KEY/${x["id"]}")
      );
      final ratings = jsonDecode(ratingresponse.body);
      showList.add(TVShow(x["id"], x["title"], x["description"], x["image"], ratings["imDb"], ""));
    }

    return showList;
  }

}
