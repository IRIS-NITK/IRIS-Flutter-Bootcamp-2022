import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviez/Models/Movie.dart';
import 'package:moviez/Widgets/MovieCard.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, required this.title}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future? searchMovie() async {
    final response = await http.get(
      Uri.parse(
          "https://imdb-api.com/en/API/SearchMovie/k_xh9z4xcu/${widget.title}"),
    );
    final body = jsonDecode(response.body);
    return body["results"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Movies"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: searchMovie(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Some error occurred. Please try again",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data as List;
              if (movies != null) {
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) => MovieCard(
                    movie: Movies(
                      title: movies[i]["title"],
                      imdb: '',
                      year: '',
                      image: movies[i]["image"],
                      movieId: movies[i]["id"],
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: Text("No movies found",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
