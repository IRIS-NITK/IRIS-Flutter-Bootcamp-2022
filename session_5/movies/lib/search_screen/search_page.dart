import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:movies/homepage/movie.dart';
import 'package:movies/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/homepage/moviecard.dart';
import 'package:movies/bloc/movie_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future? future;
  final TextEditingController _searchController = TextEditingController();
  Future? getMovies(String s) async {
    final response;
    response = await http.get(
        Uri.parse("https://imdb-api.com/en/API/Search/${Constant.key}/$s"));
    final body = jsonDecode(response.body);
    final movies = body["results"];
    return movies;
  }

  @override
  void initState() {
    super.initState();
    future = getMovies("");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        listener: (context, state) {},
        builder: (context, value) {
          return BlocConsumer<SearchCubit, String>(listener: (context, state) {
            future = getMovies(state);
          }, builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                      color: (value) ? Colors.white : Colors.black),
                  centerTitle: true,
                  title: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<SearchCubit>().update(value);
                    },
                    style:
                        TextStyle(color: (value) ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                        hintText: "Search Something....",
                        hintStyle: TextStyle(
                            color: (value) ? Colors.white : Colors.black),
                        border: InputBorder.none,
                        iconColor: (value) ? Colors.white : Colors.black),
                  ),
                  elevation: 1,
                  backgroundColor: (value) ? Colors.black : Colors.white,
                ),
                body: FutureBuilder(
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
                                    rating: movies[index]["imDbRating"] ?? "no",
                                    cast: movies[index]["crew"] ?? ""),
                              ));
                            }),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child:
                                Text("Some error occurred. Please try again"),
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline_outlined,
                                  color:
                                      (value) ? Colors.orange : Colors.purple,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "No movies found",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: (value)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return Center(
                          child: CircularProgressIndicator(
                        color: (value) ? Colors.orange : Colors.purple,
                      ));
                    }));
          });
        });
  }
}
