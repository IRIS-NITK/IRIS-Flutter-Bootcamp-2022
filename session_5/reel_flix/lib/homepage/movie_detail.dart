import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/movie_bloc.dart';
import 'package:movies/homepage/movie.dart';
import 'package:movies/constants.dart' as Constant;
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expandable_text/expandable_text.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double rate = 0;
  Future? desc;
  String vid = "", wiki = "";

  Future<String> getDescription(String id) async {
    final response = await http.get(Uri.parse(
        "https://imdb-api.com/en/API/Wikipedia/${Constant.Constant.key}/${widget.movie.id}"));
    final body = jsonDecode(response.body);
    final desc = body["plotShort"]["plainText"] ?? "";
    return desc;
  }

  Future<String> getTrailer() async {
    final response = await http.get(Uri.parse(
        "https://imdb-api.com/en/API/Trailer/${Constant.Constant.key}/${widget.movie.id}"));
    final body = jsonDecode(response.body);
    final vid = body["link"] ?? "";
    return vid;
  }

  Future<String> getWiki() async {
    final response = await http.get(Uri.parse(
        "https://imdb-api.com/en/API/Wikipedia/${Constant.Constant.key}/${widget.movie.id}"));
    final body = jsonDecode(response.body);
    final wiki = body["url"] ?? "";
    return wiki;
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();
    try {
      rate = double.parse(widget.movie.rating);
    } catch (e) {
      rate = 0;
    } finally {
      desc = getDescription(widget.movie.id);
      getTrailer().then((value) {
        vid = value;
      });
      getWiki().then((value) {
        wiki = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: (state) ? Colors.black : Colors.white,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: (state) ? Colors.orange : Colors.purple,
                title: Text(widget.movie.title),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 270,
                      child: Stack(children: [
                        Column(
                          children: [
                            Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (state)
                                          ? Colors.orange
                                          : Colors.purple,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50))),
                                ),
                                flex: 4),
                            Flexible(
                                child: Container(
                                  color: (state) ? Colors.black : Colors.white,
                                ),
                                flex: 1),
                          ],
                        ),
                        Positioned(
                            top: 30,
                            left: 10,
                            child: Container(
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.white, spreadRadius: 1),
                                ]),
                                width: 180,
                                height: 240,
                                child: Image.network(
                                  widget.movie.image,
                                  fit: BoxFit.cover,
                                ))),
                        Positioned(
                            left: 250,
                            top: 47,
                            child: Column(
                              children: [
                                (widget.movie.rank != "no")
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.crown,
                                                  size: 25,
                                                  color: (state)
                                                      ? Colors.black
                                                      : Colors.white),
                                              const SizedBox(width: 7)
                                            ],
                                          ),
                                          Text(
                                            widget.movie.rank,
                                            style: TextStyle(
                                                color: (state)
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    : const SizedBox(
                                        height: 43,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (widget.movie.rating != "no")
                                    ? Row(
                                        children: [
                                          Text(
                                            widget.movie.rating,
                                            style: TextStyle(
                                                color: (state)
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("/10",
                                              style: TextStyle(
                                                  color: (state)
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 20))
                                        ],
                                      )
                                    : Container(),
                                (rate != 0)
                                    ? Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: rate / 2,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: (state)
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: TextStyle(
                                color: (!state) ? Colors.black : Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Year:",
                                style: TextStyle(
                                    color:
                                        (!state) ? Colors.black : Colors.white,
                                    fontSize: 17),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.movie.year,
                                style: TextStyle(
                                    color:
                                        (!state) ? Colors.black : Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Cast: ",
                                style: TextStyle(
                                    color:
                                        (!state) ? Colors.black : Colors.white,
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  widget.movie.cast,
                                  style: TextStyle(
                                      color: (!state)
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Description:",
                            style: TextStyle(
                                color: (!state) ? Colors.black : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FutureBuilder(
                              future: desc,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    final desc = snapshot.data;
                                    return ExpandableText(
                                      desc,
                                      linkStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: (state)
                                              ? Colors.white
                                              : Colors.black),
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      maxLines: 4,
                                      animation: true,
                                      animationDuration:
                                          const Duration(seconds: 1),
                                      linkColor: (state)
                                          ? Colors.orange
                                          : Colors.purple,
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                          "Some error occurred. Please try again"),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("No Description found"),
                                    );
                                  }
                                }

                                return Center(
                                    child: CircularProgressIndicator(
                                  color:
                                      (state) ? Colors.orange : Colors.purple,
                                ));
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  try {
                                    _launchURL(vid);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Could not Launch the page :( !!")));
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.film,
                                  size: 40,
                                  color:
                                      (state) ? Colors.orange : Colors.purple,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    try {
                                      _launchURL(wiki);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Could not Launch the page :( !!")));
                                    }
                                  },
                                  color:
                                      (state) ? Colors.orange : Colors.purple,
                                  iconSize: 35,
                                  icon: const Icon(FontAwesomeIcons.wikipediaW))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
