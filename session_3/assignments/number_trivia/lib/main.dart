import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;

Color primaryColor = Colors.deepPurple.shade700;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Number Trivia",
    theme: ThemeData(),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var choice = "";
  var inputfact = "";
  var factdisplay = "";
  bool check = false;
  displayfact(String choice) async {
    var url = "http://numbersapi.com/";
    if ((choice == "number") && (numberController.text).isNotEmpty) {
      url = url + (numberController.text);
    } else if ((choice == "math") && (mathController.text).isNotEmpty) {
      url = url + (mathController.text) + "/math";
    } else if ((choice == "date") &&
        (((monthController.text).isNotEmpty) &&
            ((dateController.text).isNotEmpty))) {
      url =
          url + (monthController.text) + "/" + (dateController.text) + "/date";
    } else if ((choice == "year") && (yearController.text).isNotEmpty) {
      url = url + (yearController.text) + "/year";
    } else {
      var rnd = Random();
      url = url + "${rnd.nextInt(100)}";
    }
    var response = await http.get(Uri.parse(url));
    factdisplay = response.body;
    setState(() {});
    print(factdisplay + choice);
  }
  // displayfact_random

  final numberController = TextEditingController();
  final mathController = TextEditingController();
  final monthController = TextEditingController();
  final dateController = TextEditingController();
  final yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia!"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            choice = "number";
                          });
                        },
                        color: primaryColor,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Text(
                            "Trivia",
                            textScaleFactor: 1.32,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              choice = "math";
                            });
                          },
                          color: primaryColor,
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text("Math", textScaleFactor: 1.32),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              choice = "date";
                            });
                          },
                          color: primaryColor,
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text("Date", textScaleFactor: 1.32),
                          )),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              choice = "year";
                            });
                          },
                          color: primaryColor,
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text("Year", textScaleFactor: 1.32),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.0),
              if (choice == "number") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    controller: numberController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Number",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ] else if (choice == "math") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    controller: mathController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Number",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ] else if (choice == "date") ...[
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: monthController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "MM",
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(" / ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: dateController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "DD",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ] else if (choice == "year") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    controller: yearController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Year",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ] else ...[
                Text(""),
              ],
              SizedBox(height: 28.0),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      displayfact(choice);
                      // choice = ".";
                    });
                  },
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text("Get Trivia!", textScaleFactor: 1.32)),
              SizedBox(height: 8.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: Text(
                    factdisplay,
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sedgwick Ave',
                        letterSpacing: 2.0),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
