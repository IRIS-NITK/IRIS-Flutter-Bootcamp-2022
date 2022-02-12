import 'package:assignment_3/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box<Todo> todobox;
  TextEditingController taskcontroller = TextEditingController();
  TextEditingController utaskcontroller = TextEditingController();
  DateTime date = DateTime(1999);
  DateTime udate = DateTime(1999);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todobox = Hive.box("Todoboxname");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ToDo List",
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                          child: Column(children: [
                            Text(
                              "Enter Task details",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.purple),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: taskcontroller,
                              decoration:
                                  InputDecoration(hintText: "Enter the Task"),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              label: Text(date == DateTime(1999)
                                  ? "Pick a date"
                                  : "${date.day}/${date.month}/${date.year}"),
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: date == DateTime(1999)
                                            ? DateTime.now()
                                            : date,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024))
                                    .then((value) {
                                  setState(() {
                                    date = value!;
                                  });
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                                onPressed: () {
                                  String task = taskcontroller.text;
                                  String sdate =
                                      "${date.day}/${date.month}/${date.year}";
                                  Todo tdetails = Todo(task, sdate);
                                  todobox.add(tdetails);
                                  taskcontroller.text = "";
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add ToDo Task"))
                          ]),
                        ),
                      );
                    }));
          },
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: todobox.listenable(),
                builder: (context, Box<Todo> todos, _) {
                  List<int> keys = todos.keys.cast<int>().toList();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: keys.length,
                          itemBuilder: (_, index) {
                            int key = keys[index];
                            Todo? todo = todos.get(key);
                            return ListTile(
                              title: Text(
                                todo!.task,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22, color: Colors.purple[900]),
                                ),
                              ),
                              subtitle: Text(
                                todo.date,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.deepPurple[300]),
                                ),
                              ),
                              leading: Text(
                                "Task${index + 1}",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.purpleAccent),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return Dialog(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(children: [
                                                        TextField(
                                                          controller:
                                                              utaskcontroller,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Enter Updated Task"),
                                                        ),
                                                        SizedBox(height: 20),
                                                        ElevatedButton.icon(
                                                          label: Text(
                                                              "Update date"),
                                                          icon: Icon(Icons
                                                              .calendar_today),
                                                          onPressed: () {
                                                            showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate: udate ==
                                                                            DateTime(
                                                                                1999)
                                                                        ? DateTime
                                                                            .now()
                                                                        : udate,
                                                                    firstDate:
                                                                        DateTime
                                                                            .now(),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2024))
                                                                .then((value) {
                                                              setState(() {
                                                                udate = value!;
                                                              });
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(height: 20),
                                                        ElevatedButton.icon(
                                                            onPressed: () {
                                                              String utask =
                                                                  utaskcontroller
                                                                      .text;
                                                              String sudate =
                                                                  "${udate.day}/${udate.month}/${udate.year}";
                                                              Todo tdetails =
                                                                  Todo(utask,
                                                                      sudate);
                                                              todos.putAt(index,
                                                                  tdetails);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.update,
                                                            ),
                                                            label: Text(
                                                                "Update Task"))
                                                      ]),
                                                    ),
                                                  );
                                                }));
                                      },
                                      icon: Icon(Icons.refresh,
                                          color: Colors.purple)),
                                  IconButton(
                                      onPressed: () {
                                        todos.deleteAt(index);
                                        todos.compact();
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.purple)),
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                })
          ],
        ));
  }
}
