import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_hive_getx/app/data/hive_data_store.dart';
import 'package:task_manager_hive_getx/app/shared/models/task.dart';
import 'app/modules/home/views/home_view.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());

  //open a box
  var box = await Hive.openBox<Task>('tasks');

  //delete data from previous day
  box.values.forEach((task) {
    if (task.createdAt.day != DateTime.now().day) {
      box.delete(task.id);
    }
  });

  runApp(BaseWidget(child: MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({required this.child}) : super(child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError("Could not find ancestor widget of type BaseWidget");
    }
  }

  @override
  bool updateShouldNotify(BaseWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black))),
      home: HomeView(),
    );
  }
}
