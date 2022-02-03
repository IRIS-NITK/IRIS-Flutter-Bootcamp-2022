import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moviez/Models/TVShow.dart';
import 'package:moviez/Screens/SearchPage.dart';
import 'package:moviez/Widgets/TVCard.dart';
import 'package:http/http.dart' as http;

class TVPage extends StatefulWidget {
  const TVPage({Key? key}) : super(key: key);

  @override
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  bool search = false;

  Future? future;

  Future? getShows() async {
    var box = Hive.box('TVShows');
    try {
      final response = await http.get(
        Uri.parse("https://imdb-api.com/en/API/Top250TVs/k_xh9z4xcu"),
      );
      final body = jsonDecode(response.body);
      final List TVsbody = body["items"];
      List<TVShows> movies = [];
      for (var e in TVsbody) {
        movies.add(
          TVShows(
            title: e["title"],
            imdb: e["imDbRating"],
            year: e["year"],
            image: e["image"],
            showId: e['id'],
          ),
        );
      }
      var test = await box.put('ShowsList', movies);
      return movies;
    } catch (e) {
      List<TVShows> lmovies =
          box.get('ShowsList', defaultValue: []).cast<TVShows>();
      return lmovies;
    }
  }

  @override
  void initState() {
    super.initState();
    future = getShows();
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
            : const Text("TV Shows"),
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
            getShows();
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
                  final shows = snapshot.data;
                  return ListView.builder(
                    itemCount: shows.length,
                    itemBuilder: (context, i) => TVCard(
                      show: shows[i],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No TV shows found"),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "TV Shows")
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
