import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void wiki(String id) async {
  final url = Uri.parse("https://imdb-api.com/en/API/Wikipedia/k_z7a4flzp/$id");
  var response = await http.get(url);
  var body = jsonDecode(response.body);
  final doc = body["url"];
  if (!await launch(doc)) throw 'Could not launch $doc';
}

void yttrailer(String id) async {
  final url =
      Uri.parse("https://imdb-api.com/en/API/YouTubeTrailer/k_z7a4flzp/${id}");
  var response = await http.get(url);
  var body = jsonDecode(response.body);
  final video = body["videoUrl"];
  if (!await launch(video)) throw 'Could not launch $video';
}

class DataTile extends StatelessWidget {
  DataTile(
      {Key? key,
      required this.title,
      required this.imdb,
      required this.image,
      required this.id})
      : super(key: key);
  var title;
  var imdb;
  var image;
  var id;
  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 180,
                width: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.fill)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                imdb == ""
                    ? Text(
                        "Imdb: NA",
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        "Imdb: " + imdb + "/10",
                        style: TextStyle(fontSize: 18),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => yttrailer(id),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 30,
                        ) /*Text("Y")*/),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () => wiki(id), child: Text("Wiki"))
                  ],
                )
              ],
            ))
          ]),
        ));
  }
}
