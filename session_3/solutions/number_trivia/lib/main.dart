import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Number Trivia',
      home: NumberTrivia(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define a custom Form widget.
class NumberTrivia extends StatefulWidget {
  const NumberTrivia({Key? key}) : super(key: key);

  @override
  _NumberTriviaState createState() => _NumberTriviaState();
}

class _NumberTriviaState extends State<NumberTrivia> {
  final myController = TextEditingController();

  String text = "";
  final numController = TextEditingController();

  void callNumTrivia(int number) async {
    try {
      var url = Uri.parse("http://numbersapi.com/${number}/trivia");
      setState(() {
        text = "Fun facts about your favorite number just seconds away.";
      });
      final response = await http.get(url);
      setState(() {
        text = response.body;
      });
    } catch (e) {
      setState(() {
        text = "Please check your internet connection and try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          begin:Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple,Colors.orange]
        ) 
      ) ,
    child: Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('Number Trivia'),
        ),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 30, 30),
            child: const Text(
            "Fun facts about your favorite number just a click away!",
             style: TextStyle(
             color: Color.fromARGB(255,0,0,0),
             fontSize: 25,
             fontFamily: 'Roboto',
             fontWeight: FontWeight.w700
             )),
          ),
          TextField(
            controller: myController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: "Enter a number"),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(120, 0, 120, 20),
              child: ElevatedButton.icon(
                onPressed: () => callNumTrivia(int.parse(myController.text)), 
                label:  const Text('Go'),
                icon: const Icon(Icons.play_arrow_rounded),
                )),
          Center(
            child:Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue,Colors.purple]),
              boxShadow:[ 
               BoxShadow(
                  color: Colors.redAccent.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2),) ]),
            
            padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
              child:Text(
                text,
                style: const TextStyle(
                color: Color.fromARGB(255, 255,255,255),
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400)
                )
              )
          )
        ])));
  }
}
