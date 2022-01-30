import 'package:flutter/material.dart';

import 'home_screen.dart';

class launchScreen extends StatefulWidget {
  const launchScreen({Key? key}) : super(key: key);

  @override
  _launchScreenState createState() => _launchScreenState();
}

class _launchScreenState extends State<launchScreen> {

  @override
  void initState()
  {
    super.initState();
    _tohome();
  }

  void _tohome() async{
    await Future.delayed(const Duration(milliseconds: 2000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Icon(Icons.home)],
        )
      )
    );
  }
}
