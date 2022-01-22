import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

int num = int.parse(qwerty.text);
String tempo = " ";

class Trivia extends StatefulWidget {
  const Trivia({Key? key}) : super(key: key);

  @override
  _TriviaState createState() => _TriviaState();
}

class _TriviaState extends State<Trivia> {
  int temp = -1;

  Future fact() async {
    temp = 1;

    var url = Uri.parse("http://numbersapi.com/$num");
    final response = await http.get(url);

    // debugPrint("$body");

    setState(() {
      tempo = response.body;
    });
    debugPrint(tempo);
  }

  @override
  void initState() {
    fact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 210, 53, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 210, 53, 1),
        title: const Text(
          "TRIVIA TIME",
          style: TextStyle(
              fontFamily: 'mochiy', color: Colors.indigo, fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120.0,
            ),
            Text(
              "Trivia on $num",
              // textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 55,
                  fontFamily: 'sedgwick',
                  color: Colors.deepPurple),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              tempo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30, fontFamily: 'sedgwick', color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
