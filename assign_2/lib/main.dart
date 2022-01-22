import 'package:assign_2/random.dart';
import 'package:assign_2/trivia.dart';
import 'package:flutter/material.dart';

var qwerty = TextEditingController();
// var number = num.text;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "trivia application",
      home: TApp(),
    );
  }
}

class TApp extends StatefulWidget {
  const TApp({Key? key}) : super(key: key);

  @override
  _TAppState createState() => _TAppState();
}

class _TAppState extends State<TApp> {
  // final _numcontroller = TextEditingController();
  // var number = num.text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 210, 53, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(image: AssetImage('assets/images/last.jpg')),
              const SizedBox(height: 20.0),
              const Text(
                "Enter the number:",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.blueAccent,
                    fontFamily: 'mochiy'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: qwerty,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 50),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.deepOrange,
                    fontFamily: 'mochiy'),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Trivia()),
                  );
                },
                child: const Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurpleAccent,
                      fontFamily: 'mochiy'),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    side: const BorderSide(color: Colors.blueAccent)),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Randomtri()),
                  );
                },
                child: const Text(
                  "Random Number",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurpleAccent,
                      fontFamily: 'mochiy'),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    side: const BorderSide(color: Colors.blueAccent)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
