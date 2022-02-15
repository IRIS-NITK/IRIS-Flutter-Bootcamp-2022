import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final user_taskState every = user_taskState();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String y = "hello";
  String r = "hel";
  var box = Hive.openBox('tasks');
  int i = 0;
  List<String> k = every.p;
  List<String> l = every.t;
  void test() {
    List f = every.disp();

    print(f);
    setState(() {});
  }

  void rec() {
    print("hey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'TO-DO',
            style: TextStyle(
                color: const Color(0xFF303030), fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xFFA5D6A7),
        shadowColor: const Color(0xFF263238),
        leading: Tooltip(
            message: 'Add task',
            child: IconButton(
                icon: Icon(Icons.add_box_outlined),
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return user_task();
                    }),
                  );
                })),
      ),
      body: ListView(children: task2()),
      floatingActionButton: FloatingActionButton(
          onPressed: test,
          tooltip: 'View tasks',
          child: Icon(Icons.remove_red_eye)),
    );
  }

  Widget task3(String title, String subtitle) {
    return ListTile(
        leading: Icon(Icons.alarm_sharp),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Wrap(
          children: <Widget>[
            Tooltip(
              message: "complete",
              child: IconButton(
                onPressed: () {
                  every.del(title);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> task2() {
    final List<Widget> task1 = [];
    for (i = 0; i < k.length; i++) {
      task1.add(Card(child: task3(k[i], l[i])));
    }
    return task1;
  }
}
