import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main(){
  runApp(new number_trivia());
}


class number_trivia extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Number Trivia App",
      home: Scaffold(
        appBar: AppBar(title: const Text("Number Trivia App",style: TextStyle(fontSize: 30,color: Colors.black),),centerTitle: true,),
      body: main_body(),
      ),
    );
  }
}

class main_body extends StatefulWidget{
  @override
  State<main_body> createState() => _main_bodyState();
}

class _main_bodyState extends State<main_body> {
  @override
  final control_1=TextEditingController();
  String ans="";
  Future<void> get_num() async {
   String url="http://numbersapi.com/";
   url+=control_1.text;
   final response= await http.get(Uri.parse(url));
   setState(() {
     ans=response.body;
   });
  }


  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              cursorHeight: 20,
              controller: control_1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: "Enter the number",border:InputBorder.none),
            ),
            OutlinedButton(onPressed: get_num, child: Text("Submit")),
            Text("$ans",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
          ],
        ),
      ),
    )
    );
  }
}