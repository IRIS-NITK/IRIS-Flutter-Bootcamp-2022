import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: HomePage(), debugShowCheckedModeBanner: false);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _trivia = "";
  Color _color = const Color.fromRGBO(0, 0, 0, 1);
  final numController = TextEditingController();

  void getTrivia() async {
    int num = 0;

    if (numController.text == "") {
      
        var url = Uri.parse("http://numbersapi.com/random?min=0&max=100/trivia");
        setState(() {
          _trivia = "Fetching your random fact. Please wait....";
          _color = const Color.fromRGBO(0, 100, 0, 1);
        });
        try{
        final response = await http.get(url);
        setState(() {
          _trivia = response.body;
          _color = const Color.fromRGBO(0, 0, 0, 1);
        });
        return;
      } catch (e) {
        _trivia = "Please check your internet connection and try again.";
        _color = const Color.fromRGBO(255, 0, 0, 1);
        return;
      }
    }
    try {
      num = int.parse(numController.text);
    } catch (e) {
      setState(() {
        _trivia = "Please enter a valid number.";
        _color = const Color.fromRGBO(255, 0, 0, 1);
      });
      return;
    }
    if (num >= 0 && num <= 100) {
      try {
        var url = Uri.parse("http://numbersapi.com/${numController.text}");
        setState(() {
          _trivia = "Fetching your random fact. Please wait....";
          _color = const Color.fromRGBO(0, 100, 0, 1);
        });
        final response = await http.get(url);
        setState(() {
          _trivia = response.body;
          _color = const Color.fromRGBO(0, 0, 0, 1);
        });
      } catch (e) {
        setState(() {
          _trivia = "Please check your internet connection and try again.";
          _color = const Color.fromRGBO(255, 0, 0, 1);
        });
      }
    } else {
      setState(() {
        _trivia = "Number not within range.";
        _color = const Color.fromRGBO(255, 0, 0, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Number Trivia App")),
        body: Center(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: numController,
                decoration: const InputDecoration(
                    hintText:
                        "Enter a number in mind(If blank, get random fact)"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              OutlinedButton(
                onPressed: getTrivia,
                child: const Text('Get Trivia!!'),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Trivia",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            decoration: TextDecoration.underline)),
                  ]),
              const SizedBox(
                height: 10.0,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Text(
                        _trivia == "" ? "Trivias are interesting." : _trivia,
                        style: TextStyle(color: _color, fontSize: 30, fontFamily: 'Outfit', fontWeight: FontWeight.w400)))
              ])
            ],
          )),
        )));
  }
}
