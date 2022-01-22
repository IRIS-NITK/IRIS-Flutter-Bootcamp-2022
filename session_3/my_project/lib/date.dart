import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDate extends StatelessWidget {
  const MyDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Num_trivia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen2(),
    );
  }
}

class MainScreen2 extends StatefulWidget {
  const MainScreen2({Key? key}) : super(key: key);

  @override
  _MainScreen2State createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {
  final _numcontroll = TextEditingController();
  final _numcontroll2 = TextEditingController();
  String triv = "";

  void find_date() async {
    String n1 = _numcontroll.text;
    String n2 = _numcontroll2.text;
    String url = ("http://numbersapi.com/$n1/$n2");

    final respo = await http.get(Uri.parse(url));
    triv = respo.body;

    setState(() {});
  }

  void find_rand() async {
    String url = "http://numbersapi.com/random/date";

    final respo = await http.get(Uri.parse(url));
    triv = respo.body;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/logo.png'),
              onPressed: () {},
            );
          },
        ),
        title: const Text(
          'SKYTRIV',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'BebasNeue',
          ),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please enter month :',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numcontroll,
                  decoration: InputDecoration(hintText: 'In 1-12'),
                  maxLength: 2,
                ),
                Text(
                  'Please enter date :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numcontroll2,
                  decoration: InputDecoration(hintText: 'In 1-31'),
                  maxLength: 2,
                ),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(onPressed: find_date, child: Text('Trivia')),
                    OutlinedButton(onPressed: find_rand, child: Text('Random')),
                  ],
                ),
                Text(
                  'Here is your trivia : \n\n $triv',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
