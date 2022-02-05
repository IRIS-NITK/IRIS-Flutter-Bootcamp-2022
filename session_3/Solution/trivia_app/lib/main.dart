import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia_app/home_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/MyTrivia': (BuildContext context) => new MyTrivia()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MyTrivia');
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/main_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text("Welcome To Number Trivia Application",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Alice",
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                          color: Colors.white))),
              new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(right: 23.0),
                child: new Image.asset(
                  'images/logo.png',
                  width: 600,
                  height: 500,
                ),
              ),
              new Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text("Unimportant  Matters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Sacramento",
                          fontWeight: FontWeight.w800,
                          fontSize: 35.0,
                          color: Colors.white))),
            ],
          )),
        ),
      ),
    );
  }
}
