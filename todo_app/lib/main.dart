import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/tasksmodel.dart';
import 'boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(tasksAdapter());
  await Hive.openBox<tasks>("todotasks");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _titledescController = TextEditingController();

  void dispose() {
    Hive.close();

    super.dispose();
  }

  void addTodoItem(String title, String titledesc, DateTime deaddate) {
    final task = tasks()
      ..title = title
      ..titledesc = titledesc
      ..deadline = deaddate;

    final box = Boxes.getTasks();
    box.add(task);

    _titleController.clear();
    _titledescController.clear();
  }

  void deleteTodoItem(int i, tasks task) {
    task.delete();

    _titleController.clear();
    _titledescController.clear();
  }

  void editTodoItem(String newtitle, String newtitledesc, DateTime newdate,
      int i, tasks task) {
    task.title = newtitle;
    task.titledesc = newtitledesc;
    task.deadline = newdate;

    task.save();
    _titleController.clear();
    _titledescController.clear();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDo App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<Box<tasks>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final todotasks = box.values.toList().cast<tasks>();

          return buildContent(todotasks);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        child: const Text(
          "+",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  String timeleft(DateTime deadday) {
    if (deadday.difference(DateTime.now()).inMinutes < 2) {
      return "a few seconds left";
    } else if (deadday.difference(DateTime.now()).inMinutes < 60) {
      return "${deadday.difference(DateTime.now()).inMinutes} min";
    } else if (deadday.difference(DateTime.now()).inMinutes < 1440) {
      return "${deadday.difference(DateTime.now()).inHours} hours";
    } else if (deadday.difference(DateTime.now()).inMinutes > 1440) {
      return "${deadday.difference(DateTime.now()).inDays} days";
    } else {
      return "invalid time";
    }
  }

  Future _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task'),
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: SingleChildScrollView(
              child: Container(
                height: 400,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: 'Title'),
                    ),
                    TextFormField(
                      controller: _titledescController,
                      decoration: const InputDecoration(
                          hintText: 'Enter task description here'),
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('select deadline '),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      width: 500,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newDateTime) {
                          selectedDate = newDateTime;
                        },
                        use24hFormat: false,
                        minuteInterval: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                  'ADD',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  addTodoItem(_titleController.text, _titledescController.text,
                      selectedDate);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _titleController.clear();
                  _titledescController.clear();
                },
              )
            ],
          );
        });
  }

  Future _taskDialog(BuildContext context, String title, String titledesc,
      DateTime deadday, int i, tasks task) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(task.title),
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.symmetric(horizontal: 30),
              content: SingleChildScrollView(
                child: Container(
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          task.titledesc,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(children: [
                          Text("Deadline : "),
                          Text('${task.deadline.day}' +
                              "/" +
                              "${task.deadline.month}" +
                              "/" +
                              "${task.deadline.year}"),
                        ]),
                        Row(
                          children: [
                            Text("Deadline Time: "),
                            Text('${task.deadline.hour}' +
                                ":" +
                                "${task.deadline.minute}")
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _editDialog(context, title, titledesc,
                                      deadday, i, task);
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {
                                  deleteTodoItem(i, task);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Future _editDialog(BuildContext context, String inittitle,
      String inittaskdesc, DateTime initday, int i, tasks task) async {
    final TextEditingController _newtitleController =
        TextEditingController(text: task.title);
    final TextEditingController _newtitledescController =
        TextEditingController(text: task.titledesc);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit'),
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: SingleChildScrollView(
              child: Container(
                height: 400,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _newtitleController,
                      decoration: const InputDecoration(hintText: 'Title'),
                    ),
                    TextFormField(
                      controller: _newtitledescController,
                      decoration: const InputDecoration(
                          hintText: 'Enter task description here'),
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("deadline"),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: 500,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime: task.deadline,
                        onDateTimeChanged: (DateTime newDateTime) {
                          selectedDate = newDateTime;
                        },
                        use24hFormat: false,
                        minuteInterval: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Save Changes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  editTodoItem(_newtitleController.text,
                      _newtitledescController.text, selectedDate, i, task);
                },
              ),
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _titleController.clear();
                  _titledescController.clear();
                },
              )
            ],
          );
        });
  }

  Widget buildContent(List<tasks> todotasks) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: todotasks.length,
            itemBuilder: (BuildContext context, int i) {
              final task = todotasks[i];

              return Card(
                  color: Colors.lightBlue,
                  child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        timeleft(task.deadline),
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => _taskDialog(context, task.title,
                          task.titledesc, task.deadline, i, task)));
            },
          ),
        ),
      ],
    );
  }
}
