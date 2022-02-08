import 'package:flutter/material.dart';

import 'screen_bloc.dart';
import 'screen_builder.dart';

void main() {
  runApp(MyApp());
}

class Movies {
  var Title;
  var Fulltitle;
  var Year;
  var Image;
  var Imdb;
  var Id;
  Movies(var title, var year, var image, var imdb, var id) {
    Title = title;

    Year = year;
    Image = image;
    Imdb = imdb;
    Id = id;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IMDB App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? future;

  List<String> Actions = [
    "Top 250 movies",
    "Top 250 TVs",
    "Popular Movies",
    "Popular TVs",
    "In Theaters",
    "Coming Soon"
  ];

  actionfunc(int i) {
    if (i == 0) {
      return action.top250movies;
    } else if (i == 1) {
      return action.top250tvs;
    } else if (i == 2) {
      return action.popularmovies;
    } else if (i == 3) {
      return action.populartvs;
    } else if (i == 4) {
      return action.intheaters;
    } else {
      return action.comingsoon;
    }
  }

  final actbloc = screen_bloc();

  @override
  void initState() {
    actbloc.eventsink.add(action.top250movies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: actbloc.titlestream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data}");
            } else {
              return Text(" ");
            }
          },
        ),
      ),
      body: ScreenBuilder(future: actbloc.screenstream),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Actions"),
          ),
          body: ListView.builder(
              itemCount: Actions.length,
              itemBuilder: (context, i) {
                return Card(
                    child: ListTile(
                  onTap: () {
                    actbloc.eventsink.add(actionfunc(i));

                    Navigator.of(context).pop();
                  },
                  title: Text(Actions[i]),
                ));
              }),
        ),
      ),
    );
  }
}
