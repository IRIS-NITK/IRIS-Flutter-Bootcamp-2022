import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task.dart';
import 'widgets.dart';
import 'boxes.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('To-Do App')),
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          final unfinishedTasks = tasks.where((task) => !task.isCompleted);

          return ListView(
            children: unfinishedTasks
                .map((task) => TaskCardWidget(task: task))
                .toList(),
          );
        },
      ),
      floatingActionButton: NewTaskModalWidget(),
    );
  }
}
