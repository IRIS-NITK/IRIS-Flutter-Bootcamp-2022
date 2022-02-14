import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final myController1 = TextEditingController();
  String _trivia = "";
  String check = "";

  void getApi() async
  {
    _trivia='';
    String url = "http://numbersapi.com/";
    final response = await http.get(Uri.parse(url + myController1.text.toString()));
    
    setState(() {
     _trivia=response.body;    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        title: const Text(
          "TR1V14",
          style: TextStyle(
            color: Colors.yellow,
          ),
          ),
        centerTitle: true,
      ),
      body: Center(
        
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to the TR1V14 App! Enter any number and be enlightened!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    ),
                  ),
              
                  const SizedBox(
                    height: 50.0,
                  ),
              
                  const SizedBox(
                    height: 30,
                  ),
              
                  const Text(
                    "Input your number here",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Schyler',
                    fontStyle: FontStyle.italic, 
                    color: Colors.black87,
                    ),
                  ),
              
                  TextFormField(
                    controller: myController1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 20.0,
                  ),
              
                  OutlinedButton(
                    onPressed: (){
                      getApi();
                    },
                    child: const Text(
                      "Get Number Trivia!",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
              
                  const SizedBox(
                    height: 20.0,
                  ), 
              
                  Text(
                    "Here is your fact: $_trivia",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.pink,
                    ),
                  ),
                ],
            ),
          ),
        ),
        ),
    );
  }
}

