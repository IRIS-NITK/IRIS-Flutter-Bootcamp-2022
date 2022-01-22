// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget buildcard() => Card(
      shadowColor: Colors.grey,
      elevation: 12,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                // ignore: prefer_const_constructors
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1443&q=80'),
                height: 200,
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 11,
                right: 11,
                left: 10,
                child: Text(
                  "hi nice to see you",
                  style: TextStyle(color: Colors.white, fontFamily: "Hugme"),
                ),
              )
            ],
          ),
        ],
      ));

  final TextEditingController _tc = TextEditingController();

  void randomnum() {
    int num = Random().nextInt(100);
    _str = num.toString();
    fetch2();
  }
 Future<void> fetch2() async {
    String rep = await getresp(_str);
    setState(() {
       _tc.text=_str;
      _str = rep;
    });
    _result = 1;
  }
  int _result = 0;
  String _str = "";
  Future<String> getresp(String i) async {
    if (i != "") {
      var mod = "http://numbersapi.com/" + i;
      var url = Uri.parse(mod);
      var response = await http.get(url);
      String body = response.body;
      return body;
    }
    return ' ';
  }

  Future<void> fetch() async {
    String str = _tc.text.toString();
    String rep = await getresp(str);
    setState(() {
      _str = rep;
      
    });
    _result = 1;
  }

  Widget resultcard() => Card(
      shadowColor: Colors.red,
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.purple.shade300],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _result < 0 ? ' ' : _str,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "mangat",
                ),
              ),
            ],
          )));

  Widget beautifycard() => Card(
        shadowColor: Colors.red,
        elevation: 20,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.orange.shade900],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
          padding: const EdgeInsets.all(40).copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "THIS IS A NUMBER TRIVIA ",
                style: TextStyle(
                    fontSize: 15, color: Colors.white, fontFamily: 'Hugme'),
              ),
              TextField(
                controller: _tc,
                
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Hugme'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                maxLength: 4,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          color: Colors.white, fontFamily: "Hugme"),
                      primary: Colors.blueGrey,
                      onPrimary: Colors.blueGrey,
                      onSurface: Colors.blueGrey,
                    ),
                    onPressed: fetch,
                    child: const Text(
                      "fetch",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            color: Colors.white, fontFamily: "Hugme"),
                        primary: Colors.blueGrey,
                        onPrimary: Colors.blueGrey,
                        onSurface: Colors.blueGrey,
                      ),
                      onPressed: randomnum,
                      child: const Text(
                        "random",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              "IRIS BOOT !! camp",
              style: TextStyle(fontFamily: "Whiskey"),
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [buildcard(), resultcard(), beautifycard()],
          )),
    );
  }
}
