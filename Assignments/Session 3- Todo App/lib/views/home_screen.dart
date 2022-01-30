import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo_iris_bootcamp/model/todos.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'add_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> listTodos = [];
  void getTodos() async {
    final box = await Hive.openBox<Todo>('todos');

    setState(() {
      listTodos = box.values.toList();
    });
  }

  void initState() {
    getTodos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 34, 34, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(7, 100, 38, 1.0),
        title: Text(
          'To-Do',
          style: GoogleFonts.kanit(
            fontWeight: FontWeight.w600,
            fontSize: 33,
            color: Color.fromRGBO(157, 9, 9, 1.0),
          ),
        ),
        centerTitle: true,
        elevation: 20,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddTodo(false),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: listTodos.length,
          itemBuilder: (context, position) {
            Todo getTodos = listTodos[position];
            var title = getTodos.title;
            int endTime = getTodos.now.millisecondsSinceEpoch;
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              elevation: 4,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(15),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        getTodos.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 45),
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        AddTodo(true, position, getTodos)),
                              );
                            }),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            final box = Hive.box<Todo>('todos');
                            box.deleteAt(position);
                            setState(() => {listTodos.removeAt(position)});
                          }),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text(
                              'Time Up!',
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          return Text(
                            '${time.days ?? 0}d, ${time.hours ?? 0}h, ${time.min ?? 0}m, ${time.sec ?? 0}s',
                            style: TextStyle(color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
