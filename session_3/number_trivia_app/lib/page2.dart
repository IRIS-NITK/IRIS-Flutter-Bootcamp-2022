import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page1.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

String url = '';
String dat = '';
String replica = '';

class _ResultScreenState extends State<ResultScreen> {
  Future getNumData() async {
    setState(() {
      url = "http://numbersapi.com/${inpVal.text}/trivia";
      replica = inpVal.text;
    });
    final response = await http.get(Uri.parse(url));
    setState(() {
      dat = response.body;
    });
  }

  @override
  void initState() {
    getNumData();
    super.initState();
  }

  Widget loadAnimation() {
    if (dat.compareTo('') == 0)
      return AnimatedTextKit(animatedTexts: [
        TyperAnimatedText("Loading...",
            textStyle: TextStyle(
              fontSize: 40.0,
              fontFamily: 'Dongle',
            ),
            textAlign: TextAlign.center)
      ]);
    else
      return Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        child: Text(
          dat,
          style: TextStyle(fontSize: 40.0, fontFamily: 'Dongle'),
          textAlign: TextAlign.center,
        ),
      );
  }

  Widget reset() {
    inpVal.text = '';
    dat = '';
    return Container();
  }

  Widget backGround() {
    AssetImage assetImage = AssetImage('images/bgimg.png');
    Image image = Image(image: assetImage);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NUMBER FACT",
          style: TextStyle(fontFamily: 'Lato'),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 150, bottom: 150),
            child: Center(
              child: Text(
                replica,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 150.0, fontFamily: 'Dongle'),
              ),
            ),
          ),
          loadAnimation(),
          reset(),
        ],
      ),
    );
  }
}
