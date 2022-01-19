import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Display extends StatefulWidget {
  final String num;
  const Display(this.num);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  initState() {
    get1();
    get2();
    get3();
  }

  late String data1;
  late String data2;
  late String data3;
  void get1() async {
    var url = "http://numbersapi.com/${widget.num}/math?json";
    final response = await get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      data1 = jsonDecode(response.body)["text"];
    });
    print(data1);
  }

  void get2() async {
    var url = "http://numbersapi.com/${widget.num}/trivia?json";
    final response = await get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      data2 = jsonDecode(response.body)["text"];
    });
    print(data2);
  }

  void get3() async {
    var url = "http://numbersapi.com/${widget.num}/year?json";
    final response = await get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      data3 = jsonDecode(response.body)["text"];
    });
    print(data3);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: Text('Number Trivia'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Color.fromRGBO(255, 0, 0, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Math",
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(0, 203, 151, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            data1,
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            minFontSize: 10,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Card(
              color: Color.fromRGBO(26, 238, 243, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Trivia",
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(255, 164, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            data2,
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            minFontSize: 10,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Card(
              color: Color.fromRGBO(81, 245, 104, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Year",
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(207, 10, 97, 1.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            data3,
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            minFontSize: 10,
                            maxLines: 10,
                            //overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
