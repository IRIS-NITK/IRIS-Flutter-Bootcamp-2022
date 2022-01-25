import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app_bootcamp/models/movie.dart';
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
    print('called');
    var box = await Hive.openBox('movies');
    try {
      final response = await http.get(
        Uri.parse("https://imdb-api.com/en/API/Top250Movies/k_u1ns7npq"),
      );
      print(response);
      final body = jsonDecode(response.body);
      final List moviesbody = body["items"];
      print(moviesbody.length);
      List<Movies> movies = [];

      for (var e in moviesbody) {
        print('##############');
        movies.add(
          Movies(
            title: e["title"],
            imdb: e["imDbRating"],
            year: e["year"],
            image: e["image"],
            movieId: e['id'],
          ),
        );
      }
      print(movies.length);

      var test = await box.put('moviesList', movies);
      print(box.path);

      return movies;
    } catch (e) {
      print('reached her');
      List<Movies> lmovies =
          box.get('moviesList', defaultValue: []).cast<Movies>();
      return lmovies;
    }
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getMovies();
          });
        },
        child: Container(
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
                  print(movies.length);
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, i) => MovieCard(
                      movie: movies[i],
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
      ),
    );
  }
}
