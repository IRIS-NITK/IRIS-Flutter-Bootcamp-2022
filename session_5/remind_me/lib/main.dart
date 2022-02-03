import 'package:flutter/material.dart';
import 'package:remind_me/Screens/HomePage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/Models/tasks.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('Tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}
