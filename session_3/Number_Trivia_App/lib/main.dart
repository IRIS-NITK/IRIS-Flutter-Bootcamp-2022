import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.red[50],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _numController = TextEditingController();
  String number_fact = "";
  int _num = 0;
  var isLoading = false;

  void getFact() async {
    try {
      setState(() {
        isLoading = true;
      });
      int.parse(_numController.text);
    } on FormatException {
      _num = 404;
      number_fact = "Try entering an Integer ";
      setState(() {
        isLoading = false;
      });
    } finally {
      int? number = int.parse(_numController.text);
      var url = Uri.parse("http://numbersapi.com/$number");
      final fact = await http.get(url);
      number_fact = fact.body;
      _num = number;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Number Trivia"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: number_fact == ""
                    ? const Text("Let's Start!!")
                    : (isLoading)
                        ? LoadingRotating.square()
                        : Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    number_fact,
                                    maxLines: 8,
                                    style: const TextStyle(
                                        fontSize: 20, fontFamily: 'Sans-serif'),
                                  ),
                                )
                              ],
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _numController,
                  decoration: const InputDecoration(
                    hintText: "Enter a Number",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        getFact();
                      },
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          backgroundColor: Colors.red[600],
                          shadowColor: Colors.black,
                          primary: Colors.white),
                      child: const Text("Get Fact")),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
