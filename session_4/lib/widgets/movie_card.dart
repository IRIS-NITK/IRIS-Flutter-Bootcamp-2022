import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String? imdb;
  final String? year;
  final String image;
  final String movieId;
  const MovieCard(
      {Key? key,
      required this.title,
      this.imdb,
      this.year,
      required this.image,
      required this.movieId})
      : super(key: key);

  void launchUrl(String url) async {
    if (!await launch(url)) throw "Could not launch $url";
  }

  void viewTrailer(id) async {
    String API_KEY = "";
    final url = "https://imdb-api.com/en/API/Trailer/${API_KEY}/" +
        id; // url to get link of trailer for a particular movie
    final response = await http.get(
      Uri.parse(url),
    );
    final trailerData = jsonDecode(response.body);
    launchUrl(trailerData["link"]);
  }

  void viewWikipediaPage(id) async {
    String API_KEY = "";
    final url = "https://imdb-api.com/en/API/Wikipedia/${API_KEY}/" + id;
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
          leading: Image.network(image),
          title: Text(
            title,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imdb != null
                  ? Text(
                      "IMdB: $imdb",
                    )
                  : Container(),
              year != null
                  ? Text(
                      "Year: $year",
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
                    viewTrailer(movieId);
                  },
                  child: const Text(
                    "Y",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    viewWikipediaPage(movieId);
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
