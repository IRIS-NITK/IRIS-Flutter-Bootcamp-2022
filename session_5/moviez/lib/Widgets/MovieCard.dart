import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviez/Models/Movie.dart';
import 'package:moviez/Screens/MovieDetail.dart';
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
    final url = "https://imdb-api.com/en/API/Trailer/k_xh9z4xcu/" + id;
    final response = await http.get(
      Uri.parse(url),
    );
    final trailerData = jsonDecode(response.body);
    launchUrl(trailerData["link"]);
  }

  void viewWikipediaPage(id) async {
    final url = "https://imdb-api.com/en/API/Wikipedia/k_xh9z4xcu/" + id;
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
                      "IMdB Rating: ${movie.imdb}",
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
                IconButton(
                  onPressed: () {
                    viewTrailer(movie.movieId);
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () {
                    viewWikipediaPage(movie.movieId);
                  },
                  icon: const Icon(Icons.web),
                ),
                /*IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MovieDetail(movie: movie);
                      }));
                    },
                    icon: const Icon(Icons.info_outline))*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
