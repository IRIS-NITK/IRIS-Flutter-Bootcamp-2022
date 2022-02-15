import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app_bootcamp/screens/search_screen.dart';
import 'package:movie_app_bootcamp/widgets/movie_card.dart';
import 'package:http/http.dart' as http;

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool search = false;

  // List movies = [
  //   {"name": "Inception", "imdb": "8.8", "year": "2008"},
  //   {"name": "Shutter Island", "imdb": "8.8", "year": "2008"},
  //   {"name": "Revenant", "imdb": "8.8", "year": "2008"},
  //   {"name": "Blood Diamond", "imdb": "8.8", "year": "2008"},
  //   {"name": "Titanic", "imdb": "8.8", "year": "2008"}
  // ];

  Future? future;

  Future? getMovies() async {
    String API_KEY = "";
    final response = await http.get(
      Uri.parse("https://imdb-api.com/en/API/Top250Movies/${API_KEY}"),
    );
    final body = jsonDecode(response.body);
    final movies = body["items"];
    return movies;
  }

  @override
  void initState() {
    super.initState();
    future = getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: search
            ? TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchScreen(title: value);
                        },
                      ),
                    );
                  }
                },
              )
            : const Text("Movies App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              search = !search;
              setState(() {});
            },
            icon: search ? const Icon(Icons.close) : const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some error occurred. Please try again"),
                );
              } else if (snapshot.hasData) {
                final movies = snapshot.data;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) => MovieCard(
                    title: movies[i]["title"],
                    imdb: movies[i]["imDbRating"],
                    year: movies[i]["year"],
                    image: movies[i]["image"],
                    movieId: movies[i]["id"],
                  ),
                );
              } else {
                return const Center(
                  child: Text("No movies found"),
                );
              }
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
