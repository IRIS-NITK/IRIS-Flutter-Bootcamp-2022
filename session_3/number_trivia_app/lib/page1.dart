import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_trivia_app/main.dart';
import 'package:number_trivia_app/page2.dart';

var opt = ['-Select-', 'User Input Number', 'Random Number'];
var curOpt = '-Select-';
var inpVal = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget homeImage() {
    AssetImage assetImage = AssetImage('images/fpimg.png');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }

  void dropDownSel(String? newVal) {
    setState(() {
      String x = newVal.toString();
      curOpt = x;
    });
  }

  void genRandNo() {
    var random = Random();
    int randNo = random.nextInt(100);
    inpVal.text = randNo.toString();
  }

  Widget txtFld() {
    if ((curOpt.compareTo('-Select-')) == 0 ||
        curOpt.compareTo('Random Number') == 0) {
      return Container();
    } else
      return Container(
        padding: EdgeInsets.only(left: 140.0, right: 140.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: inpVal,
          decoration: InputDecoration(
            label: Text(
              "Number",
              style: TextStyle(fontFamily: 'Lato'),
            ),
            hintText: "Enter Any Number",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      );
  }

  Widget buttonCall() {
    if ((curOpt.compareTo('-Select-')) == 0) {
      return Container();
    } else if ((curOpt.compareTo('Random Number')) == 0) {
      genRandNo();
      return Container(
        padding: EdgeInsets.only(left: 140.0, right: 140.0),
        child: RaisedButton(
          elevation: 6.0,
          color: Colors.black,
          child: Text(
            "Know Fact",
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: 'Lato'),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResultScreen();
            }));
          },
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 140.0, right: 140.0),
        child: RaisedButton(
          elevation: 6.0,
          color: Colors.black,
          child: Text(
            "Know Fact",
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: 'Lato'),
          ),
          onPressed: () {
            restrictions(context);
          },
        ),
      );
    }
  }

  Widget appInfo() {
    if ((curOpt.compareTo('-Select-')) == 0) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "Explore the World of NUMBERS by Entering Any Number of Your Choice or Even by just Entering a Random Number and Knowing an Interesting Fact About Them!",
          style: TextStyle(fontSize: 25.0, fontFamily: 'Lato'),
          textAlign: TextAlign.center,
        ),
      );
    } else
      return Container();
  }

  Widget restrictionMsg() {
    if (inpVal.text.compareTo('') == 0)
      return Text(
        "No Number Entered!",
        style: TextStyle(fontFamily: 'Lato'),
      );
    else
      return Text(
        "Value out of bounds",
        style: TextStyle(fontFamily: 'Lato'),
      );
  }

  void restrictions(BuildContext context) {
    //A Snack Bar about the error will be returned as a widget!
    if (inpVal.text.compareTo('') == 0 ||
        int.parse(inpVal.text) > 9999 ||
        int.parse(inpVal.text) < -9999) {
      var sb = SnackBar(
        content: restrictionMsg(),
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
      setState(() {
        inpVal.text = '';
      });
    } else
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ResultScreen();
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.restart_alt_rounded),
          tooltip: "Reset",
          onPressed: () {
            setState(() {
              inpVal.text = '';
              curOpt = '-Select-';
            });
          },
        ),
        appBar: AppBar(
          title: Text(
            "NUMBER TRIVIA",
            style: TextStyle(fontFamily: 'Lato'),
          ),
          backgroundColor: Colors.indigo,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            homeImage(),
            Container(
              height: 50.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 140.0, right: 142.0),
              child: DropdownButton(
                  items: opt.map((String val) {
                    return DropdownMenuItem(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  value: curOpt,
                  onChanged: (String? newVal) {
                    dropDownSel(newVal);
                  }),
            ),
            Container(
              height: 50.0,
            ),
            appInfo(),
            txtFld(),
            Container(
              height: 50.0,
            ),
            buttonCall(),
          ],
        ));
  }
}
