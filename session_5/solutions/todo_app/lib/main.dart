import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/todo_model.dart';

const String todoBoxName = "todo";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());

  await Hive.openBox(todoBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemindR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Box todoBox;
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box(todoBoxName);
  }

  late var date;
  late var time;

  Future PickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDate == null) {
      date = "No date selected";
    } else {
      setState(() {
        date = "${newDate.day}/${newDate.month}/${newDate.year}";
      });
    }
  }

  Future PickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) {
      time = "No time selected";
    } else {
      setState(() {
        time = "${newTime.hour}:${newTime.minute}";
      });
    }
  }

  takeInput(key, n) {
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(hintText: "Title"),
                    controller: titleController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () => PickDate(context),
                      child: const Text("Select date")),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () => PickTime(context),
                      child: const Text("Select time")),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      child: const Text("Add Todo"),
                      onPressed: () {
                        ///Todo : Add Todo in hive
                        final String title = titleController.text;
                        TodoModel todo =
                            TodoModel(title: title, date: date, time: time);
                        if (n == 1) {
                          todoBox.put(key, todo);
                        } else {
                          todoBox.add(todo);
                        }

                        Navigator.pop(context);
                      })
                ]));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("RemindR"),
          actions: const <Widget>[],
        ),
        body: Column(children: <Widget>[
          ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, Box todos, _) {
                List<int> keys = todos.keys.cast<int>().toList();

                return ListView.separated(
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final TodoModel todo = todos.get(key);
                    return ListTile(
                        title: Text(todo.title),
                        subtitle: Text("Scheduled on:${todo.date} at ${todo.time}"),
                        leading: GestureDetector(
                          child: const Icon(Icons.delete),
                          onTap: () => todos.delete(key),
                        ),
                        onTap: () => takeInput(key, 1));
                  },
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: keys.length,
                  shrinkWrap: true,
                );
              })
        ]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () => takeInput(0, 0)));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
