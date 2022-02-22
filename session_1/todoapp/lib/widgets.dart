import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'boxes.dart';
import 'task.dart';

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(widget.task.title),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                EditTaskModalWidget(
                  task: widget.task,
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () => deleteTask(widget.task),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Complete",
                  style: TextStyle(color: Colors.blue),
                ),
                Checkbox(
                  value: ischecked,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        ischecked = value!;
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }

  void taskCompleted(Task task) {
    task.isCompleted = true;

    task.save();
  }
}

class NewTaskModalWidget extends StatelessWidget {
  NewTaskModalWidget({Key? key}) : super(key: key);

  final taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextField(
                            autofocus: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(60)
                            ],
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(25),
                              hintText: 'Enter the Task',
                              labelText: 'My Task',
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 3,
                            controller: taskTitleController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () => {
                                taskTitleController.text = "",
                                Navigator.pop(context)
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Add Task'),
                              onPressed: () => {
                                addTask(taskTitleController.text),
                                taskTitleController.text = "",
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addTask(String title) {
    final task = Task()
      ..title = title == "" ? "(Untitled)" : title
      ..isCompleted = false;

    final box = Boxes.getTasks();
    box.add(task);
  }
}

class EditTaskModalWidget extends StatelessWidget {
  EditTaskModalWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  final taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Edit'),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(60)
                            ],
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(25),
                              hintText: 'Enter the Task',
                              labelText: 'My Task',
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 3,
                            controller: taskTitleController..text = task.title,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () => {Navigator.pop(context)},
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Edit Task'),
                              onPressed: () =>
                                  {editTask(task), Navigator.pop(context)},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void editTask(Task task) {
    task.title = taskTitleController.text;
    task.save();
  }
}
