// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trivia_application/new_user_screent.dart';
import 'package:http/http.dart' as http;

// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _value = 1;
  late String factString;

  Future<String> getFact(String numberInput, int choice) async {
    String type;

    if (choice == 1) {
      type = "trivia";
    } else {
      if (choice == 2) {
        type = "math";
      } else {
        if (choice == 3) {
          type = "date";
        } else {
          if (choice == 4) {
            type = "year";
          } else {
            type = "Random";
          }
        }
      }
    }

    var url = Uri.parse("http://numbersapi.com/" + numberInput + "/" + type);
    if (choice == 5) {
      url = Uri.parse("http://numbersapi.com/random/" + numberInput);
    }
    final response = await http.get(url);

    setState(() {
      factString = response.body;
    });

    // print(response.body);

    return response.body;
  }

  final mycontroller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trivia Application"),
          backgroundColor: Colors.indigoAccent.shade100,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Numbers are interesting aren't they",
                style: (TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text("What kind of trivia are you looking for"),
              Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        const Text("Trivia")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        const Text("Math")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                            value: 3,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        const Text("Date")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                            value: 4,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        const Text("Year")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                            value: 5,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        const Text("Random")
                      ],
                    ),
                  ],
                ),
              ),
              const Text("Wanna find one "),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  // keyboardType: (_value == 5 || _value == 3)
                  //     ? TextInputType.text
                  //     : TextInputType.number,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: _value != 5
                        ? "Enter a number/date/year"
                        : "Type number/date/year",
                  ),
                  controller: mycontroller1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton(
                  onPressed: () async {
                    String fact2 = await getFact(mycontroller1.text, _value);

                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewScreenT(
                                  fact: fact2,
                                  choice: _value,
                                  numberText: mycontroller1.text,
                                  random: _value == 5 ? true : false,
                                )),
                      );
                    });
                  },
                  child: const Text("Get a fact"))
            ],
          ),
        ));
  }
}
