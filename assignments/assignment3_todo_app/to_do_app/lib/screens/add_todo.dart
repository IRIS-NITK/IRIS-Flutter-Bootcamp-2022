import 'package:flutter/material.dart';
import 'package:todo_app/adapter/todo_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class AddTodo extends StatefulWidget {
  late bool toUpdate;
  late int? position;
  late Todo? todo;
  AddTodo(this.toUpdate, this.position, this.todo, {Key? key})
      : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  submitData() async {
    var title = controllerTitle.text;
    var description = controllerDescription.text;
    if (_formKey.currentState!.validate()) {
      await Date_Time(context);
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      if (widget.toUpdate) {
        Todo data = Todo(
            title: controllerTitle.text,
            description: controllerDescription.text,
            dateTime: dateTime,
            completionStatus: false);
        todoBox.putAt(widget.position!, data);
      } else {
        todoBox.add(Todo(
            title: title,
            description: description,
            dateTime: dateTime,
            completionStatus: false));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.toUpdate) {
      controllerTitle.text = widget.todo!.title;
      controllerDescription.text = widget.todo!.description;
    }
    return AlertDialog(
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controllerTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controllerDescription,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  child: const Text(
                    'Add ToDo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    submitData();
                    ElevatedButton.styleFrom(primary: Colors.purple[600]);
                  },
                ),
                const SizedBox(height: 10),
              ],
            )));
  }

  // ignore: non_constant_identifier_names
  Future Date_Time(BuildContext context) async {
    final date = await pickDate(context);

    final time = await pickTime(context);

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

  pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: initialDate);
    //if (date == null) date = initial_Date;
    return date ??= initialDate;
  }

  pickTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
        /*dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initial_time,*/
        );
    return time;
  }
}
