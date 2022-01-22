import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyNum extends StatelessWidget {
  const MyNum({Key? key}) : super(key: key);

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
  String triv = "";

  void find_triv() async {
    String name = _numcontroll.text;
    String url = ("http://numbersapi.com/" + name);

    final respo = await http.get(Uri.parse(url));
    triv = respo.body;

    setState(() {});
  }

  void find_math() async {
    String name = _numcontroll.text;
    String url = ("http://numbersapi.com/" + name + "/math");

    final respo = await http.get(Uri.parse(url));
    triv = respo.body;

    setState(() {});
  }

  void find_rand() async {
    String url = "http://numbersapi.com/random/trivia";

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
                  'Please enter your number :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numcontroll,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                        onPressed: find_math,
                        child: Text(
                          'Math-stuff',
                          style: TextStyle(),
                        )),
                    OutlinedButton(onPressed: find_triv, child: Text('Trivia')),
                    OutlinedButton(onPressed: find_rand, child: Text('Random')),
                  ],
                ),
                SizedBox(
                  height: 20,
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
