import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskbar/models/task.dart';

import 'package:taskbar/widgets/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? future;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  List<Tasks> li = [];
  var box;
  Future? getTasks() async {
    print('called');
    box = await Hive.openBox('tasks');
    if (li.isEmpty) {
      print('empty');
      box.put('tasklist', []);
    }
    print(box.toString());
    li = box.get('tasklist');
    print(li);
    return li;
  }

  void add() async {
    String name = myController1.text;
    String date = myController2.text;
    li.add(Tasks(name: name, dt: date));
    await box.put('tasklist', li);
  }

  @override
  void initState() {
    super.initState();
    future = getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO-DO LIST"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getTasks();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occurred. Please try again"),
                  );
                } else if (snapshot.hasData) {
                  final list = snapshot.data;
                  print(list.length);
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) => TaskCard(
                      task: list[i],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No tasks assigned"),
                  );
                }
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => popup(context),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }

  Widget popup(BuildContext context) {
    return AlertDialog(
      title: const Text('ADD A USER'),
      content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Enter the task name'),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: myController1,
        ),
        const SizedBox(
          height: 30.0,
        ),
        const Text('Enter the deadline date and time'),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: myController2,
        ),
        const SizedBox(
          height: 30.0,
        ),
      ]),
      actions: <Widget>[
        TextButton(onPressed: add, child: const Text('Submit'))
      ],
    );
  }
}
