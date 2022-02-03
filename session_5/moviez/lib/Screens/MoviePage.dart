import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moviez/Models/Movie.dart';
import 'package:moviez/Screens/SearchPage.dart';
import 'package:moviez/Screens/TVPage.dart';
import 'package:moviez/Widgets/MovieCard.dart';
import 'package:http/http.dart' as http;

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  bool search = false;

  Future? future;

  Future? getMovies() async {
    var box = Hive.box('Movies');
    try {
      final response = await http.get(
        Uri.parse("https://imdb-api.com/en/API/Top250Movies/k_xh9z4xcu"),
      );
      final body = jsonDecode(response.body);
      final List moviesbody = body["items"];
      List<Movies> movies = [];
      for (var e in moviesbody) {
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
      var test = await box.put('MoviesList', movies);
      return movies;
    } catch (e) {
      List<Movies> lmovies =
          box.get('MoviesList', defaultValue: []).cast<Movies>();
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
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchPage(title: value);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "TV Shows")
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const TVPage();
            }));
          }
        },
      ),
    );
  }
}
