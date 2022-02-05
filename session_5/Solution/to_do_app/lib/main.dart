import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:to_do_app/task_list.dart';
import 'tasks.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskAdapter());

   runApp( MaterialApp(
    home:  const MyApp(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/MyTasks': (BuildContext context) => const TaskList()
    },
  ));
}

class  MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    startTime() async {
    var _duration =  const Duration(seconds: 5);
    return  Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MyTasks');
  }

  @override
  void initState() {
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
        child:  Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child:  Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: const Text("Welcome To To-Do Application",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Alice",
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0,
                          color: Colors.white))),
               Container(
                margin: const EdgeInsets.only(right: 23.0),
                child:  Image.asset(
                  'images/bg_icon.png',
                  width: 600,
                  height: 500,
                ),
              ),
               Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text("Balancing Energy With Simplicity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Sacramento",
                          fontWeight: FontWeight.w800,
                          fontSize: 35.0,
                          color: Colors.white))),
            ],
          )),
        ),
      ),
    );
  }

}
