import 'package:flutter/material.dart';
import 'package:movies_app/screens/movie_screen.dart';

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
    _toInitScreen();
  }

  void _toInitScreen() async{
    await Future.delayed(const Duration(seconds: 2), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MovieScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const <Widget>[
            Icon(Icons.home)
          ],
        )
      )
    );
  }
}
