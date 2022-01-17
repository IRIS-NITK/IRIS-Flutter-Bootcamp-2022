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
        scaffoldBackgroundColor: Colors.green[50],
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
  String numfact = "";
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
      numfact = "The Input is not an Integer!! Try entering an Integer ";
      setState(() {
        isLoading = false;
      });
    } finally {
      int? number = int.parse(_numController.text);
      var url = Uri.parse("http://numbersapi.com/$number");
      final fact = await http.get(url);
      numfact = fact.body;
      _num = number;
      setState(() {
        isLoading = false;
      });
    }
  }

  void getRandom() async {
    setState(() {
      _numController.text = "";
      isLoading = true;
    });
    Random random = Random();
    int number = random.nextInt(1000);
    var url = Uri.parse("http://numbersapi.com/$number");
    final fact = await http.get(url);
    numfact = fact.body;
    _num = number;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Number Trivia Application"),
        backgroundColor: Colors.green[500],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: numfact == ""
                  ? const Text("No Input")
                  : (isLoading)
                      ? LoadingRotating.square()
                      : Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 5),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0))),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text("$_num",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace')),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  numfact,
                                  maxLines: 8,
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: 'Georgia'),
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
                        side: const BorderSide(width: 4, color: Colors.green),
                        backgroundColor: Colors.teal[600],
                        shadowColor: Colors.black,
                        primary: Colors.white),
                    child: const Text("Get Fact")),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                    onPressed: () {
                      getRandom();
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        side: const BorderSide(width: 4, color: Colors.green),
                        backgroundColor: Colors.teal[600],
                        shadowColor: Colors.black,
                        primary: Colors.white),
                    child: const Text("Random Number")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
