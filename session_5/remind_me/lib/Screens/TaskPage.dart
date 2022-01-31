import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/Models/tasks.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var b;
  late Tasks todo;

  @override
  void initState() {
    b = Hive.box<Tasks>('Tasks');
    todo = b.getAt(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Task Name",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(todo.task, style: const TextStyle(fontSize: 35.5)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "Deadline:",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                      DateFormat('dd/MM/yyyy').format(todo.date) +
                          ", " +
                          DateFormat('hh:mm').format(todo.time),
                      style: const TextStyle(
                        fontSize: 35.0,
                      )),
                  const SizedBox(height: 30.0),
                  TextButton(
                      onPressed: () {
                        b.deleteAt(widget.index);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Mark as Completed",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ))
                ],
              )),
        ));
  }
}
