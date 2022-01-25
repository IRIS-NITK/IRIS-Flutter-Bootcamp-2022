import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';

class MyTrivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  var _formKey = GlobalKey<FormState>();

  var border;

  var minpadding = 5.0;
  void initState() {
    this.border = BoxDecoration();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  // ignore: non_constant_identifier_names
  TextEditingController user_number = TextEditingController();

  var displaytrivia = '';

  String labelText = "Enter Number";

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    TextStyle? textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Number Trivia Application",
          style: TextStyle(fontFamily: "YesevaOne"),
        ),
        centerTitle: true,
      ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: [
          Icons.copy,
          Icons.refresh,
          Icons.close,
        ],
        secondaryIconsText: [
          "Copy",
          "Refresh",
          "Close",
        ],
        secondaryIconsOnPress: [
          () => {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Copy'),
                    content: const Text('Do you want to copy the fact?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'CANCEL'),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => {
                          FlutterClipboard.copy(displaytrivia),
                          showsnackbar(),
                          Navigator.pop(context, 'CANCEL'),
                        },
                        child: const Text('COPY'),
                      ),
                    ],
                  ),
                ),
              },
          () => {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Refresh'),
                    content: const Text('Do you want to refresh the screen?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'CANCEL'),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyTrivia()),
                            (Route<dynamic> route) => false),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              },
          () => {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Exit'),
                    content: const Text('Do you want to close the app?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'CANCEL'),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              },
        ],
        secondaryBackgroundColor: Theme.of(context).cardColor,
        secondaryForegroundColor: Theme.of(context).accentColor,
        primaryBackgroundColor: Colors.amber[600],
        primaryForegroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(minpadding * 2),
                child: ListView(
                  children: [
                    getImage(),
                    Padding(
                        padding: EdgeInsets.only(
                            top: minpadding * 5, bottom: minpadding * 4),
                        child: TextFormField(
                          style: textStyle,
                          keyboardType: TextInputType.phone,
                          controller: user_number,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Any Integer";
                            } else {
                              if (_Valid_Number(value) == false) {
                                return "Please Enter Only Integer";
                              }
                            }
                          },
                          onTap: () {
                            setState(() {
                              border=BoxDecoration();
                              labelText = "Number";
                              displaytrivia = "";
                            });
                          },
                          decoration: InputDecoration(
                              labelText: labelText,
                              labelStyle: textStyle,
                              hintText: "Enter Number e.g 42",
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Container(
                      width: minpadding * 5,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: minpadding, bottom: minpadding * 2),
                        child: Row(
                          children: [
                            Expanded(
                              // ignore: deprecated_member_use
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 70.0,
                                    top: 10.0,
                                    right: 70.0,
                                    bottom: 10.0),
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      GetTrivia();
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.blue, Colors.pink],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "GET  TRIVIA  FACT",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontFamily: "Cookie",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(minpadding * 2),
                        child: Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(minpadding * 2),
                          decoration: border,
                          child: Text(
                            this.displaytrivia,
                            style: TextStyle(
                                fontFamily: "Philosopher Italic",
                                fontSize: 24.0),
                          ),
                        ))
                  ],
                ))),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetimage = AssetImage('images/Trivia.png');
    Image image = Image(
      image: assetimage,
    );
    return Container(
      child: image,
      width: 125.0,
      height: 125.0,
      margin: EdgeInsets.all(minpadding * 5),
    );
  }

  // ignore: non_constant_identifier_names
  void GetTrivia() async {
    final number = user_number.text;
    var url = Uri.parse("http://numberapi.com/$number/trivia?json");
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    if (body["found"]) {
      displaytrivia = body["text"];
    } else {
      displaytrivia = "TRIVIA FACT IS NOT FOUND FOR $number";
    }
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      border = BoxDecoration(
        border: Border(
          left: BorderSide(
            //                   <--- left side
            color: Colors.redAccent,
            width: 3.0,
          ),
          top: BorderSide(
            //                    <--- top side
            color: Colors.pinkAccent,
            width: 3.0,
          ),
        ),
      );
    });
  }

  void showsnackbar() {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: const Text('Copied to clipboard!',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          )),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'OK',
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void reset() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyTrivia()),
      (Route<dynamic> route) => false,
    );
  }

  // ignore: non_constant_identifier_names
  bool _Valid_Number(String res) {
    setState(() {
      displaytrivia = "";
    });
    // ignore: unnecessary_null_comparison
    if (res == null) {
      return false;
    }
    // ignore: unnecessary_null_comparison
    if (num.tryParse(res) != null) {
      if (res.contains('.')) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
