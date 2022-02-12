import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(
      const MaterialApp(home: MainScreen(), debugShowCheckedModeBanner: false));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _numbercontroller = TextEditingController();
  String _trivia = "";
  int num = 0;

  void getTrivia() async {
    num = int.parse(_numbercontroller.text);
    String url = "http://numbersapi.com/$num";
    final response = await http.get(Uri.parse(url));
    final body = response.body;
    _trivia = body;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Number Trivia",
          style: TextStyle(
            fontFamily: 'Proxima Nova',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
          child: Text(
            "Welcome to Number Trivia!!",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'ComicNeue',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _trivia.isEmpty
            ? const Text("Please Enter a number for a Trivia",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Proxima Nova',
                ))
            : Text(
                "Here is an intresting fact about the number $num \n$_trivia",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Proxima Nova',
                ),
                textAlign: TextAlign.center,
              ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: _numbercontroller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintText: ("Enter a number for a fun fact!!")),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () {
            getTrivia();
          },
          icon: const Icon(MdiIcons.headLightbulb),
          label: const Text("Get Trivia",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Proxima Nova',
              )),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        )
      ]),
      backgroundColor: Colors.grey[400],
    );
  }
}
