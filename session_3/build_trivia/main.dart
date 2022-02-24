import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Build Trivia',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomePage> {
  final _numController = TextEditingController();
  //invalid to deal with invalid inputs
  bool invalid = false;
  String fact = '';
  void getFact() async {
    int n = 0;

    var url;

    // If the text entered is not a valid integer , a random integer is chosen
    if (int.tryParse(_numController.text) == null)
      invalid = true;
    else
      n = int.parse(_numController.text);

    if (invalid) {
      url = Uri.parse("https://numbersapi.com/random");
    } else {
      url = Uri.parse("https://numbersapi.com/#$n/?notfound=floor");
    }
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST,OPTIONS,GET"
    });
    setState(() {
      fact = response.body;
    });
    if (invalid) print('Invalid Input!!! A random number chosen');
    print(fact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Build Trivia"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "The craziest widgets in the world are NUMBERS. Playing with them is fun, though dangerous. Each number has its own value and importance, specially the day you were born :-)  ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontFamily: 'LuxuriousRoman'), //Customized font
                ),
                const SizedBox(
                  height: 90.0,
                ),
                const Text(
                  "Know the tale of numbers. Let's get going on the shoes of Digits ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: 'LuxuriousRoman'), //Customized input
                ),
                const Text(
                  "Enter a number of your choice",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green), //Green text
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _numController,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    onPressed: getFact,
                    child: const Text('Display fact',
                        style: TextStyle(fontStyle: FontStyle.italic))),
                Text(invalid
                    ? "INVALID INPUT!!:-( . A random number taken"
                    : ""),
                Text(fact),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
