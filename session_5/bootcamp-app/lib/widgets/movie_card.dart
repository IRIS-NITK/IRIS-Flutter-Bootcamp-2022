import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_bootcamp/models/movie.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  void launchUrl(String url) async {
    if (!await launch(url)) throw "Could not launch $url";
  }

  void viewTrailer(id) async {
    final url = "https://imdb-api.com/en/API/Trailer/k_u1ns7npq/" +
        id; // url to get link of trailer for a particular movie
    final response = await http.get(
      Uri.parse(url),
    );
    final trailerData = jsonDecode(response.body);
    launchUrl(trailerData["link"]);
  }

  void viewWikipediaPage(id) async {
    final url = "https://imdb-api.com/en/API/Wikipedia/k_u1ns7npq/" + id;
    final response = await http.get(
      Uri.parse(url),
    );
    final wikiData = jsonDecode(response.body);
    launchUrl(wikiData["url"]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: ExpansionTile(
          leading: Image.network(
            movie.image,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          title: Text(
            movie.title,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie.imdb != ''
                  ? Text(
                      "IMdB: ${movie.imdb}",
                    )
                  : Container(),
              movie.year != ''
                  ? Text(
                      "Year: ${movie.year}",
                    )
                  : Container(),
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    viewTrailer(movie.movieId);
                  },
                  child: const Text(
                    "Y",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    viewWikipediaPage(movie.movieId);
                  },
                  child: const Text(
                    "W",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
