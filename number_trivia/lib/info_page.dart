import 'package:flutter/material.dart';

class Infopage extends StatelessWidget {
  const Infopage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightGreen,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => info()));
      },
      child: Text("i",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          )),
    );
  }
}

class info extends StatelessWidget {
  const info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Information of the App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "> This app is developed for getting facts about any number ",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
              "> Just enter the no. in the box and press get facts and you will get the facts about the number",
              style: TextStyle(fontSize: 22)),
          SizedBox(
            height: 30,
          ),
          Text(
              "> For some numbers there are more then one facts to know diiferent facts just press on the get facts button again",
              style: TextStyle(fontSize: 22)),
          SizedBox(
            height: 30,
          ),
          Text(">Special Thanks to numbersapi for providing the facts",
              style: TextStyle(fontSize: 22))
        ],
      ),
    );
  }
}
