import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Mainscreen(),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final controller1 = TextEditingController();
  String y = "";
  void getfact() async {
    int x = int.parse(controller1.text);
    String s = x.toString();
    var url = Uri.parse("http://numbersapi.com/" + s);
    final response = await http.get(url);
    String body = response.body;
    print(body);
    setState(() {
      y = "FUN FACT: " + body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'NUMBER TRIVIA',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        shadowColor: Color(0xFF283593),
        backgroundColor: Color(0xFF263238),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ENTER YOUR NUMBER',
                style: GoogleFonts.mcLaren(),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller1,
              ),
              SizedBox(height: 30),
              OutlinedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: getfact,
                child: const Text(
                  'FACT',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50),
              Text("$y"),
              const SizedBox(
                height: 40.0,
              ),
              Icon(
                Icons.sailing_sharp,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[50],
    );
  }
}
