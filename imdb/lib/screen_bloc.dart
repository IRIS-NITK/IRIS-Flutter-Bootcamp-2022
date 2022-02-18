import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';

enum action {
  top250movies,
  top250tvs,
  popularmovies,
  populartvs,
  intheaters,
  comingsoon,
  search,
  stopsearch
}

class screen_bloc {
  final _statestreamcontroller = StreamController<List<Movies>>();
  StreamSink<List<Movies>> get _screensink => _statestreamcontroller.sink;
  Stream<List<Movies>> get screenstream => _statestreamcontroller.stream;

  final _titlecontroller = StreamController<String>();
  StreamSink<String> get _titlesink => _titlecontroller.sink;
  Stream<String> get titlestream => _titlecontroller.stream;

  final _eventstreamcontroller = StreamController<action>();
  StreamSink<action> get eventsink => _eventstreamcontroller.sink;
  Stream<action> get _eventstream => _eventstreamcontroller.stream;
  bool search = false;
  screen_bloc() {
    _eventstream.listen((event) async {
      if (event == action.top250movies) {
        try {
          _titlesink.add("Top 250 movies");
          var future = await getdata(
              "https://imdb-api.com/en/API/Top250Movies/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      } else if (event == action.top250tvs) {
        try {
          _titlesink.add("Top 250 TVs");
          var future =
              await getdata("https://imdb-api.com/en/API/Top250TVs/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      } else if (event == action.popularmovies) {
        try {
          _titlesink.add("Popular Movies");
          var future = await getdata(
              "https://imdb-api.com/en/API/MostPopularMovies/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      } else if (event == action.populartvs) {
        try {
          _titlesink.add("Popular TVs");
          var future = await getdata(
              "https://imdb-api.com/en/API/MostPopularTVs/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      } else if (event == action.intheaters) {
        try {
          _titlesink.add("In Theaters");
          var future = await getdata(
              "https://imdb-api.com/en/API/InTheaters/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      } else if (event == action.comingsoon) {
        try {
          _titlesink.add("Coming Soon");
          var future = await getdata(
              "https://imdb-api.com/en/API/ComingSoon/k_z7a4flzp");
          _screensink.add(future);
        } on Exception catch (e) {
          _screensink.addError("Something went wrong");
        }
      }
    });
  }
}

class SearchBloc {
  final _statestreamcontroller = StreamController<List>();
  StreamSink<List> get _screensink => _statestreamcontroller.sink;
  Stream<List> get screenstream => _statestreamcontroller.stream;

  final _searchcontroller = StreamController();
  StreamSink get searchsink => _searchcontroller.sink;
  Stream get _searchstream => _searchcontroller.stream;

  SearchBloc() {
    _searchstream.listen((event) async {
      var items = await searchMovie(event);
      _screensink.add(items);
    });
  }
}

Future getdata(String URL) async {
  var url = Uri.parse(URL);

  var response = await http.get(url);
  var body = jsonDecode(response.body);
  List<Movies> tempdata = [];
  for (int i = 0; i < body["items"].length; i++) {
    Movies item = Movies(
        body["items"][i]["title"],
        body["items"][i]["year"],
        body["items"][i]["image"],
        body["items"][i]["imDbRating"],
        body["items"][i]["id"]);
    tempdata.add(item);
  }
  return tempdata;
}

Future searchMovie(String title) async {
  final response = await http.get(
    Uri.parse("https://imdb-api.com/en/API/SearchMovie/k_z7a4flzp/${title}"),
  );

  final body = jsonDecode(response.body);

  return body["results"];
}
