// import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
            bodyText2: TextStyle(
          fontSize: 17,
          color: Colors.teal,
        )),
        appBarTheme: AppBarTheme(
          color: Colors.green[200],
          centerTitle: true,
          titleTextStyle: GoogleFonts.adamina(
            fontSize: 18,
            color: Colors.teal,
          ),
        ),
      ),
      home: const Center(child: HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myController = TextEditingController();
  bool facts = false;
  late String fact;
  String methodType = '';
  String type = 'trivia';
  void getfacts() async {
    facts = true;
    String num = myController.text;
    String urlo = 'http://numbersapi.com/';
    String url;
    if (methodType == 'random') {
      num = methodType;
    }
    if (type == 'date' && methodType == 'user') {
      final date = num.split('-');
      if (date.length == 2 &&
          (!(int.parse(date[0]) > 12) || !(int.parse(date[0]) < 1)) &&
          (!(int.parse(date[1]) > 31) || !(int.parse(date[1]) < 1))) {
        num = date[0] + '/' + date[1];
      } else {
        fact = "Wrong Date format";
        setState(() {});
        return;
      }
    }
    if (type == 'trivia') {
      url = urlo + num;
    } else {
      url = urlo + num + '/' + type;
    }

    final response = await http.get(Uri.parse(url));
    fact = response.body;
    if (num == '') {
      fact = "Oops No Input";
    }

    setState(() {});
  }

  void setMethodType(String m) {
    setState(() {
      methodType = m;
    });
  }

  void setType(String t) {
    setState(() {
      type = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Container(
                color: Colors.green[100],
                width: 400,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Center(
                  child: Text(
                    "Welcome to the number Trivia app",
                    style: GoogleFonts.alef(),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Card(
              child: Container(
                color: Colors.green[100],
                width: 400,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      "Select Genre ",
                      style: GoogleFonts.alef(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      // decoration: BoxDecoration(
                      // border: Border.all(width: 2, color: Colors.black)),
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  type == 'math'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setType('math');
                            },
                            child: const Text('Math'),
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  type == 'trivia'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setType('trivia');
                            },
                            child: const Text('Trivia'),
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  type == 'date'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setType('date');
                            },
                            child: const Text('Date'),
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  type == 'year'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setType('year');
                            },
                            child: const Text('Year'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                width: 400,
                color: Colors.green[100],
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Center(
                            child: Text(
                          'Preferred Method ',
                          style: GoogleFonts.alef(),
                        ))),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  methodType == 'random'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setMethodType('random');
                            },
                            child: const Text('Random'),
                          ),
                          OutlinedButton(
                            // color: _hasBeenPressed ? Colors.blue : Colors.black,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  methodType == 'user'
                                      ? Colors.lightGreenAccent
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setMethodType('user');
                            },
                            child: const Text('User Input'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // const SizedBox(
            //   height: 15,
            // ),
            if (methodType == 'user')
              Container(
                color: Colors.green[100],
                width: 400,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    if (type == 'year')
                      Text(
                        "Enter Year",
                        style: GoogleFonts.alef(),
                      )
                    else if (type == 'math' || type == 'trivia')
                      Text(
                        "Enter Some number",
                        style: GoogleFonts.alef(),
                      )
                    else if (type == 'date')
                      Text(
                        "Enter date and month in format mm-dd",
                        style: GoogleFonts.alef(),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (methodType == 'user')
                      Container(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: myController,
                          maxLength: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            Card(
              child: Container(
                width: 400,
                color: Colors.green[100],
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    methodType != 'random'
                        ? OutlinedButton(
                            onPressed: () {
                              getfacts();
                            },
                            child: const Text("Get Fact"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              getfacts();
                            },
                            child: const Text("Get Random Fact"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          ),
                    if (facts)
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        // padding: const EdgeInsets.symmetric(
                        //     vertical: 20, horizontal: 50),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white30, width: 2.0),
                        ),

                        // width: 300,
                        child: Text(
                          facts ? "' ${fact}' " : '',
                          style: GoogleFonts.alef(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
