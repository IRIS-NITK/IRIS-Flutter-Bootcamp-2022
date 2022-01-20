import 'package:flutter/material.dart';
import 'package:number_trivia_app/page1.dart';
import 'package:number_trivia_app/page2.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Number Trivia",
    home: HomeScreen(),
    theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.indigo,
        primaryColor: Colors.indigo),
  ));
}
