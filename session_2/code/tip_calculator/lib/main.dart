import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _result = -1.0;

  final myController1 = TextEditingController();

  final myController2 = TextEditingController();

  final myController3 = TextEditingController();

  void calculateFunction() {
    double total = double.parse(myController1.text);
    double tipPercentage = double.parse(myController2.text);
    int nPeople = int.parse(myController3.text);

    setState(() {
      _result = (total + total * tipPercentage / 100) / nPeople;
      _result = double.parse(_result.toStringAsFixed(2));
    });

    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip calculator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter the total amount:'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: myController1,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text('Enter the tip percentage:'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: myController2,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text('Enter the number of people:'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: myController3,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                OutlinedButton(
                  onPressed: calculateFunction,
                  child: const Text('Calculate'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(_result < 0
                    ? ''
                    : 'The amount each person needs to pay: $_result'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
