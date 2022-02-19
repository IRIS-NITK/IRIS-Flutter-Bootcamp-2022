import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/api_key.dart';


Future<List> getTop250Movies() async{


  Uri? url = Uri.parse('https://imdb-api.com/en/API/Top250Movies/$apiKey');
  var response = await http.get(url);
  var body = jsonDecode(response.body)["items"];

  return body;

}
Future<List> searchMovies(String expression) async{


  Uri? url = Uri.parse('https://imdb-api.com/en/API/SearchMovie/$apiKey/$expression');
  var response = await http.get(url);
  var body = jsonDecode(response.body)["results"];

  return body;

}