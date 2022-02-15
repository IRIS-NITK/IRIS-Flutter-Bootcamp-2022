import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_bootcamp/widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  final String title;
  const SearchScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future? searchMovie() async {
    String API_KEY = "";
    final response = await http.get(
      Uri.parse(
          "https://imdb-api.com/en/API/SearchMovie/${API_KEY}/${widget.title}"),
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
                child: Text("Some error occurred. Please try again"),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data as List;
              if (movies != null) {
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) => MovieCard(
                    title: movies[i]["title"],
                    image: movies[i]["image"],
                    movieId: movies[i]["id"],
                  ),
                );
              }
            } else {
              return const Center(
                child: Text("No movies found"),
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
