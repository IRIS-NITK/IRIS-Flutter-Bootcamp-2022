import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_iris_bootcamp/model/todos.dart';

import 'home_screen.dart';

class AddTodo extends StatefulWidget {
  late bool isEdit;
  late int? position;
  late Todo? todo;
  AddTodo(this.isEdit, [this.position, this.todo]);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController controllerName = new TextEditingController();
  DateTime dateTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      controllerName.text = widget.todo!.title;
    }
    return AlertDialog(
      title: Text('Add/Edit'),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: controllerName,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.done),
                    hintText: 'Add a todo',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 30),
                      primary: Colors.blue,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    pickDateTime(context);
                    if (dateTime == null) dateTime = DateTime.now();
                  },
                  child: Text("Pick Deadline",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // <-- Radius
                      ),
                      fixedSize: const Size(120, 40),
                      primary: Colors.purple,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    var text = controllerName.text;
                    if (text.isNotEmpty) {
                      if (widget.isEdit) {
                        Todo updateTodo = new Todo(title: text, now: dateTime);
                        var box = await Hive.openBox<Todo>('todos');
                        box.putAt(widget.position!, updateTodo);
                      } else {
                        Todo addTodo = new Todo(title: text, now: dateTime);
                        var box = await Hive.openBox<Todo>('todos');
                        box.add(addTodo);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (r) => false);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
