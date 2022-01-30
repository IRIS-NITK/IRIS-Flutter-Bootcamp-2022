//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/HomePageSkeleton.dart';
import 'package:todo_application/models/lists.dart';
import 'package:todo_application/models/listsManager.dart';
import 'package:todo_application/models/tasks.dart';
import 'package:todo_application/models/tasksManager.dart';
import 'package:todo_application/widgets/widgetGetter.dart';

class ListViewPage extends StatefulWidget {
  String name;
  String desc;
  int index;
  DateTime? listdate;
  ListViewPage({
    Key? key,
    required this.name,
    required this.desc,
    required this.index,
    required this.listdate,
  }) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

var wg = WidgetGetter();
String? nameOfList;
String? descOfList;
int? id;
ListsManager lm = ListsManager();
TasksManager tm = TasksManager();
var lNm = TextEditingController();
var lDs = TextEditingController();
DateTime? lDl = listDate;
TimeOfDay? lTm = listTime;

class _ListViewPageState extends State<ListViewPage> {
  @override
  void initState() {
    super.initState();
    nameOfList = widget.name;
    descOfList = widget.desc;
    id = widget.index;
    lDl = widget.listdate;
    lTm = TimeOfDay.fromDateTime(DateTime.parse(lDl.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameOfList.toString(),style: TextStyle(fontSize: 45),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        tooltip: "Add New Task",
        onPressed: () {
          wg.addNewTask(context: context, listId: id);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                descOfList.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ),
            Divider(),
            Container(
              height: 20.0,
            ),
            timeDisp(),
            Container(
              height: 20.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () async {
                  var box = await Hive.openBox<Lists>("List Data Maintainer");
                  lNm.text = nameOfList.toString();
                  lDs.text = descOfList.toString();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Text("Edit List",style: TextStyle(fontSize: 40),textAlign: TextAlign.center,),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                          label: Text(
                                            "Name of the List",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          hintText: ("Enter the Name of The List..."),
                                          hintStyle: TextStyle(fontSize: 25),
                                          border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                  ),
                                    keyboardType: TextInputType.name,
                                    controller: lNm,
                                  ),
                                  Container(height: 20.0,),
                                  TextFormField(
                                    decoration: InputDecoration(
                                          label: Text(
                                            "Description of the List",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          hintText: "Enter the Description(not more than 120 characters)...",
                                          hintStyle: TextStyle(fontSize: 25),
                                          border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                  ),
                                    keyboardType: TextInputType.multiline,
                                    controller: lDs,
                                    maxLength: 120,
                                  ),
                                  Container(height: 20.0,),
                                  RaisedButton(
                                      child: Text("Select Date",style: TextStyle(fontSize: 25),),
                                      onPressed: () async {
                                        lDl = await showDatePicker(
                                            context: context,
                                            initialDate: lDl ?? DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime(DateTime.now().year + 1));
                                      }),
                                  RaisedButton(
                                      child: Text("Select Time",style: TextStyle(fontSize: 25)),
                                      onPressed: () async {
                                        print(lTm);
                                        lTm = await showTimePicker(
                                            context: context,
                                            initialTime: lTm ??
                                                TimeOfDay.fromDateTime(
                                                    DateTime.parse(
                                                        lDl.toString())));
                                      }),
                                      Container(height: 20.0,),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (lNm.text == '') lNm.text = "<No Name>";
                                      if (lDs.text == '')
                                        lDs.text = "<No Description>";
                                      lDl = DateTime(lDl!.year, lDl!.month,
                                          lDl!.day, lTm!.hour, lTm!.minute);
                                      Lists lists = Lists(
                                        title: lNm.text,
                                        desc: lDs.text,
                                        listDate: lDl,
                                      );
                                      nameOfList = lNm.text;
                                      descOfList = lDs.text;
                            
                                      setState(() {});
                                      lm.editList(
                                          lists: lists,
                                          key: int.parse(id.toString()));
                                    },
                                    child: Text("Edit",style: TextStyle(fontSize: 25)),
                                  ),
                                ],
                              ),
                            ));
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  height: 60.0,
                  width: 60.0,
                  child: Icon(Icons.edit),
                ),
              ),
              Container(
                width: 100.0,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  for (int i = 0; i < tasksBox.length; i++) {
                    if (tasksBox.getAt(i) != null &&
                        tasksBox.getAt(i)?.listIndex ==
                            int.parse(id.toString())) {
                      tasksBox.deleteAt(i);
                      i--;
                    } else {
                      continue;
                    }
                  }
      
                  for (int i = 0; i < tasksBox.length; i++) {
                    if (int.parse((tasksBox.getAt(i)?.listIndex).toString()) >
                        int.parse(id.toString())) {
                      int k =
                          int.parse((tasksBox.getAt(i)?.listIndex).toString()) -
                              1;
                      Tasks tasks = Tasks(
                          title: tasksBox.getAt(i)?.title,
                          isDone: tasksBox.getAt(i)?.isDone,
                          listIndex: k);
                      tasksBox.putAt(i, tasks);
                    }
                  }
                  lm.deleteList(int.parse(id.toString()));
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                  height: 60.0,
                  width: 60.0,
                  child: Icon(Icons.delete),
                ),
              )
            ]),
            Container(
              height: 50.0,
            ),
            Divider(),
            Container(height:50.0),
            Container(
              height: 500,
              child: ValueListenableBuilder(
                valueListenable: tasksBox.listenable(),
                builder: (context, Box<Tasks> tasksBox, _) {
                  return ListView.builder(
                      itemCount: tasksBox.length,
                      itemBuilder: (context, index) {
                        if (tasksBox.getAt(index) != null &&
                            tasksBox.getAt(index)?.listIndex ==
                                int.parse(id.toString()))
                          return wg.taskList(
                              context: context,
                              taskName: tasksBox.getAt(index)?.title,
                              taskStatus: tasksBox.getAt(index)?.isDone,
                              taskIndex: index,
                              listIndex: id);
                        else
                          return Container();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeDisp() {
    List<Tasks?>? ts = tasksBox.values.toList();
    int counter = 0;
    for (int i = 0; i < ts.length; i++) {
      if (ts[i]!.isDone == true) {
        counter++;
      }
    }
    if (ts.isEmpty) {
      return Container(
        child: Text("No Tasks Found!",style: TextStyle(fontSize: 35),),
      );
    } else if (counter == ts.length) {
      return Container(
        child: Text("Task Completed!",style: TextStyle(fontSize: 35)),
      );
    } else if (int.parse(
                (lDl?.difference(DateTime.now()).inMinutes).toString()) >
            0 &&
        int.parse((lDl?.difference(DateTime.now()).inMinutes).toString()) <
            60) {
      return Container(
        child: Text(
            "Time Remaining for Task Completion: ${lDl?.difference(DateTime.now()).inMinutes} minutes",style: TextStyle(fontSize: 34)),
      );
    } else if (int.parse(
                (lDl?.difference(DateTime.now()).inMinutes).toString()) >
            60 &&
        int.parse((lDl?.difference(DateTime.now()).inHours).toString()) < 24) {
      return Container(
        child: Text(
            "Time Remaining for Task Completion: ${lDl?.difference(DateTime.now()).inHours} hours",style: TextStyle(fontSize: 35)),
      );
    } else if (int.parse((lDl?.difference(DateTime.now()).inHours).toString()) >
        24) {
      return Container(
        child: Text(
            "Time Remaining for Task Completion: ${lDl?.difference(DateTime.now()).inDays} days",style: TextStyle(fontSize: 35)),
      );
    } else {
      return Container(
        child: Text("Time Up!",style: TextStyle(fontSize: 35)),
      );
    }
  }
}
