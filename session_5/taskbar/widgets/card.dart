import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskbar/screens/homescreen.dart';
import 'package:taskbar/models/task.dart';

class TaskCard extends StatelessWidget {
  final Tasks task;
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  void delete(Tasks task) {
    /* var li = HomeScreen.getTasks();
    li.remove(task)
        ? SimpleDialog(
            title: const Text('TASK DELETED'),
          )
        : SimpleDialog(
            title: const Text('SORRY COULD NOT DELETE TASK'),
          ); */
  }

  void edit(Tasks task) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: ExpansionTile(
          title: Text(
            task.name,
          ),
          subtitle: Text(
            task.dt.toString(),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    delete(task);
                  },
                  child: const Text(
                    "Delete",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    edit(task);
                  },
                  child: const Text(
                    "Update",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
