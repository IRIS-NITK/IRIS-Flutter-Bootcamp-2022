import 'package:flutter/material.dart';
import 'package:flutter_application_2/date.dart';
import 'package:flutter_application_2/num.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skytriv_demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Dongle',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/logo.png'),
              onPressed: () {},
            );
          },
        ),
        title: const Text(
          'SKYTRIV',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'BebasNeue',
          ),
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'U want trivia related to ??',
              style: TextStyle(
                fontSize: 38,
              ),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyNum()),
                      );
                    },
                    child: Text(
                      'Number',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyDate()),
                      );
                    },
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: "Like",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.thumb_down),
            label: "Dislike",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: "Comment",
          )
        ],
      ),
    );
  }
}
