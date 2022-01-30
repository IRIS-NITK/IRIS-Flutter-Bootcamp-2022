import 'package:flutter/material.dart';
import 'package:remind_me/Screens/NewTask.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/Models/tasks.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/Screens/TaskPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var box;
  List<Tasks> tasks = [];
  void gettasks() {
    box = Hive.box<Tasks>('Tasks');
    setState(() {
      tasks = box.values.toList();
    });
  }

  @override
  void initState() {
    gettasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("To-Do List"),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, p) {
                    var name = tasks[p].task;
                    var dl = tasks[p].date;
                    return Card(
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              await box.deleteAt(p);
                              gettasks();
                            },
                            icon: const Icon(Icons.done)),
                        title: Text(
                          name,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy').format(dl),
                          style: TextStyle(fontSize: 15.0),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskPage(
                                index: p,
                              ),
                            ),
                          );
                          gettasks();
                        },
                      ),
                    );
                  }),
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    gettasks();
                  });
                });
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NewTask();
              }),
            );
            gettasks();
          },
          child: const Icon(Icons.add),
        ));
  }
}
