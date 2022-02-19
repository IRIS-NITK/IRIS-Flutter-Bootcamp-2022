import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/api_key.dart';


Future<List> getTop250TVs() async{


  Uri? url = Uri.parse('https://imdb-api.com/en/API/Top250TVs/$apiKey');
  var response = await http.get(url);
  var body = jsonDecode(response.body)["items"];

  return body;

}