import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
        height: 110.0,
        width: 350,
        child: DrawerHeader(
            child: Text("About the app",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        decoration: BoxDecoration(color: Colors.lightGreen),
      ),
      Text(
        "> This app is developed by Md Dilshad ",
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 30),
      Text(
        "> This app has folowing features",
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 30),
      Text(
        "1) Drawer for the information about app ui",
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 30),
      Text(
        "2) Floating action button for the information of app",
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 30),
      Text("3) Input box to enter the number", style: TextStyle(fontSize: 22)),
      SizedBox(height: 30),
      Text(
        "4) Get facts button for getting the facts about the number",
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 30),
      Text(
        "5) The facts will be displayed below the get facts button",
        style: TextStyle(fontSize: 22),
      ),
    ]));
  }
}
