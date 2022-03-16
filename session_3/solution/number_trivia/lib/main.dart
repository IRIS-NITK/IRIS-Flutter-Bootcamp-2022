import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final numberController = TextEditingController();
  String? trivia;
  void getTrivia() async {
    if (numberController.text.isEmpty) {
      trivia = "";
    } else {
      int n = int.parse(numberController.text);
      String url = "http://numbersapi.com/$n";
      final response = await http.get(Uri.parse(url));
      trivia = response.body;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Number Trivia"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter your favorite number:",
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: numberController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      getTrivia();
                    },
                    child: const Text("Get Trivia"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  trivia.toString() == "null"
                      ? const Text("")
                      : Text(
                          trivia.toString(),
                          softWrap: true,
                          textScaleFactor: 1.2,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
