import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';
import 'package:flutter/material.dart';
import 'package:movies/bloc/movie_bloc.dart';
import 'package:movies/homepage/moviecard.dart';
import 'package:movies/constants.dart';
import 'dart:async';

class MoviePage extends StatefulWidget {
  final String topic;
  const MoviePage({Key? key, required this.topic}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future? future;
  Future? getMovies(String s) async {
    final response;
    switch (s) {
      case "Top 250":
        response = await http.get(
          Uri.parse("https://imdb-api.com/en/API/Top250Movies/${Constant.key}"),
        );
        break;
      case "Most Popular":
        response = await http.get(Uri.parse(
            "https://imdb-api.com/en/API/MostPopularMovies/${Constant.key}"));
        break;
      case "In Theatres":
        response = await http.get(
          Uri.parse("https://imdb-api.com/en/API/InTheaters/${Constant.key}"),
        );
        break;
      case 'Coming Soon':
        response = await http.get(
          Uri.parse("https://imdb-api.com/en/API/ComingSoon/${Constant.key}"),
        );
        break;
      default:
        response = await http.get(
          Uri.parse("https://imdb-api.com/en/API/Top250Movies/${Constant.key}"),
        );
    }
    final body = jsonDecode(response.body);
    final movies = body["items"];
    return movies;
  }

  @override
  void initState() {
    super.initState();
    future = getMovies(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        listener: (context, state) {},
        builder: (context, theme) {
          return BlocConsumer<MovieCubit, int>(listener: (context, state) {
            future = getMovies(Constant.Mcategories[state]);
          }, builder: (context, value) {
            return Flexible(
              child: FutureBuilder(
                  future: future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final movies = snapshot.data;
                        return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 1,
                          children: List.generate(movies.length, (index) {
                            return Center(
                                child: MovieCard(
                              movie: Movie(
                                  title: movies[index]["title"] ?? " ",
                                  year: movies[index]["year"] ?? " ",
                                  image: movies[index]["image"] ?? " ",
                                  id: movies[index]["id"] ?? " ",
                                  rank: movies[index]["rank"] ?? "no",
                                  ratingCount:
                                      movies[index]["imDbRatingCount"] ?? " ",
                                  rating: movies[index]["imDbRating"] ?? " ",
                                  cast: movies[index]["crew"] ?? ""),
                            ));
                          }),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Some error occurred. Please try again"),
                        );
                      } else {
                        return const Center(
                          child: Text("No movies found"),
                        );
                      }
                    }

                    return Center(
                        child: CircularProgressIndicator(
                      color: (theme) ? Colors.orange : Colors.purple,
                    ));
                  }),
            );
          });
        });
  }
}
