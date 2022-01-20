import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _fact;
  final _inCtrl = TextEditingController();

  void getFacts(int? number) async{
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      final url = Uri.parse("http://numbersapi.com/$number");
      final response = await http.get(url, headers: headers);
      final body = jsonDecode(response.body);
      _fact = body['text'];
      setState(() { });
    }
    catch(e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Fun With Numbers!'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //nothing, just an icon
              },
              icon: const Icon(
                Icons.all_inclusive_sharp,
                color: Colors.white54
              ),
          )
      ],

      ),
      body:
        Center(
          child: SingleChildScrollView(
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Enter a number", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    width: 20
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      controller: _inCtrl,
                      decoration: const InputDecoration(
                          hintText: "Eg: 42",
                          border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.number,
                    )
                  )
                ],
              ),
              const SizedBox(
                  height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        getFacts(
                            int.parse(
                                _inCtrl.text.isNotEmpty ? _inCtrl.text : '42'
                            )
                        );
                      },
                      child: const Text(
                          "GO!",
                        style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.green,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                  )
                ],
              ),
              const SizedBox(
                height: 25
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _fact == null ? Colors.white : Colors.blue,
                        width: 1.5
                      )
                  ),
                  child: Text(
                      _fact ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )
                  )
              )
            ]
          )
      ),
        )
    );
  }
}

