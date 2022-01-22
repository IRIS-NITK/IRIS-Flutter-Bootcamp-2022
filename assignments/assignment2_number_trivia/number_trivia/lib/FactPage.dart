import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class factPage extends StatefulWidget {
  final String num;
  const factPage(this.num);

  @override
  State<factPage> createState() => _factPageState();
}

class _factPageState extends State<factPage> {
  @override
  initState() {
    fun1();
    fun2();
    fun3();
  }

  late String fact1 = "Loading...";
  late String fact2 = "Loading...";
  late String fact3 = "Loading...";

  void fun1() async {
    var url = "http://numbersapi.com/${widget.num}/math?json";
    final response = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      fact1 = jsonDecode(response.body)["text"];
    });
    print(fact1);
  }

  void fun2() async {
    var url = "http://numbersapi.com/${widget.num}/trivia?json";
    final response = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      fact2 = jsonDecode(response.body)["text"];
    });
    print(fact2);
  }

  void fun3() async {
    var url = "http://numbersapi.com/${widget.num}/year?json";
    final response = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    print(response.body);
    setState(() {
      fact3 = jsonDecode(response.body)["text"];
    });
    print(fact3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('Number Trivia'),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 40,
                color: Colors.pink[900],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Maths',
                    style: GoogleFonts.inconsolata(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 2),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 150,
                color: Colors.blue[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fact1,
                    style: GoogleFonts.courgette(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 40,
                color: Colors.pink[900],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Trivia',
                    style: GoogleFonts.inconsolata(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 2),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 150,
                color: Colors.green[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fact2,
                    style: GoogleFonts.courgette(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 40,
                color: Colors.pink[900],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Year',
                    style: GoogleFonts.inconsolata(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 2),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 150,
                color: Colors.pink[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fact1,
                    style: GoogleFonts.courgette(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
