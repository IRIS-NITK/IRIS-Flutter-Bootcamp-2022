import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Fact',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final n = TextEditingController();
  String fact = "";
  bool f = false;
  void get() async {
    String num = n.text;
    String uri = "http://numbersapi.com/" + num + "/trivia?json";
    final request = await http.get(Uri.parse(uri));
    final data = jsonDecode(request.body);
    f = true;
    setState(() {
      fact = data["text"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Number Fact"),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontFamily: "Signika",
              fontSize: 30.0,
              fontWeight: FontWeight.w700),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  "Enter a Number",
                  style: TextStyle(
                      fontFamily: "Mochiy Pop",
                      fontSize: 30.0,
                      color: Colors.white),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: n,
                  style: const TextStyle(
                      fontFamily: "Mochiy Pop",
                      color: Colors.white,
                      fontSize: 40.0),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                OutlinedButton(
                    onPressed: () {
                      get();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blue[700])),
                    child: const Text(
                      "Get Fact",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "Signika"),
                    )),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  f ? fact : "",
                  style: const TextStyle(
                      fontFamily: "Mochiy Pop",
                      fontSize: 30.0,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )));
  }
}