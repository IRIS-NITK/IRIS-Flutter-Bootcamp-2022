import 'package:flutter/material.dart';
import 'package:moviez/Models/TVShow.dart';
import 'package:moviez/Screens/MoviePage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviez/Models/Movie.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoviesAdapter());
  Hive.registerAdapter(TVShowsAdapter());
  var box1 = await Hive.openBox('Movies');
  var box2 = await Hive.openBox('TVShows');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moviez',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviePage(),
    );
  }
}
