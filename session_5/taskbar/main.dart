import 'package:flutter/material.dart';
import 'package:taskbar/models/task.dart';
import 'package:taskbar/screens/homescreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskbar',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}
