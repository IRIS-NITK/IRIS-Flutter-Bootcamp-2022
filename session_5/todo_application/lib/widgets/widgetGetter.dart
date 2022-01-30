//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:flutter/material.dart';
import 'package:todo_application/HomePageSkeleton.dart';
import 'package:todo_application/listViewPage.dart';
import 'package:todo_application/models/lists.dart';
import 'package:todo_application/models/listsManager.dart';
import 'package:todo_application/models/tasks.dart';
import 'package:todo_application/models/tasksManager.dart';

ListsManager lm = ListsManager();
TasksManager tm = TasksManager();
DateTime? listDate = DateTime.now();
TimeOfDay? listTime =
    TimeOfDay.fromDateTime(DateTime.parse(listDate.toString()));

class WidgetGetter {
  var nameOfList = TextEditingController();
  var descOfList = TextEditingController();
  var taskName = TextEditingController();

  void addNewList(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              "Add New List",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Name of the List",
                        style: TextStyle(fontSize: 25),
                      ),
                      hintText: ("Enter the Name of The List..."),
                      hintStyle: TextStyle(fontSize: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    keyboardType: TextInputType.name,
                    controller: listName,
                  ),
                  Container(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Description of the List",
                        style: TextStyle(fontSize: 25),
                      ),
                      hintText:
                          "Enter the Description(not more than 120 characters)...",
                      hintStyle: TextStyle(fontSize: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: listDesc,
                    maxLength: 120,
                  ),
                  Container(
                    height: 20.0,
                  ),
                  RaisedButton(
                      child: Text(
                        "Select Date",
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () async {
                        listDate = await showDatePicker(
                            context: context,
                            initialDate: listDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1));
                      }),
                  RaisedButton(
                      child: Text(
                        "Select Time",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      onPressed: () async {
                        listTime = await showTimePicker(
                            context: context,
                            initialTime: listTime ??
                                TimeOfDay.fromDateTime(
                                    DateTime.parse(listDate.toString())));
                      }),
                  Container(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (listName.text == '') listName.text = "<No Name>";
                      if (listDesc.text == '')
                        listDesc.text = "<No Description>";
                      DateTime? dateT = DateTime(
                          listDate!.year,
                          listDate!.month,
                          listDate!.day,
                          listTime!.hour,
                          listTime!.minute);
                      Lists lists = Lists(
                          title: listName.text,
                          desc: listDesc.text,
                          listDate: dateT);
                      listsBox.add(lists);
                      listName.text = '';
                      listDesc.text = '';
                      listDate = DateTime.now();
                      listTime = TimeOfDay.fromDateTime(
                          DateTime.parse(listDate.toString()));
                      //createDeadlineNotification();
                    },
                    child: Text(
                      "ADD List",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget generateListCard(context, Lists? lists, int index, DateTime? liD) {
    String? nmList = lists?.title ?? "<No Name>";
    String? descList = lists?.desc ?? "<No Description>";
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewPage(
                  name: nmList,
                  desc: descList,
                  index: index,
                  listdate: liD,
                );
              }));
            },
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(20.0),
              height: 200,
              width: 350,
              child: Row(
                children: [
                  Container(
                    height: 200,
                    width: 130,
                    child: imageProv("images/icon_checklist.png"),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            nmList.toString(),
                            style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            descList.toString(),
                            style: TextStyle(
                                fontSize: 25.0, height: 1, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget taskList(
      {context,
      String? taskName,
      bool? taskStatus,
      int? taskIndex,
      int? listIndex}) {
    bool tS = taskStatus ?? false;
    return Container(
        margin: EdgeInsets.only(left: 50, bottom: 15.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                tS = !tS;
                Tasks tasks =
                    Tasks(title: taskName, isDone: tS, listIndex: listIndex);
                TasksManager.editTask(
                    tasks: tasks, key: int.parse(taskIndex.toString()));
              },
              child: Container(
                width: 20.0,
                height: 20.0,
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.white)),
                child:
                    tS ? imageProv("images/icon_checkmark.png") : Container(),
              ),
            ),
            InkWell(
                onTap: () {
                  editTask(context, listIndex, taskIndex);
                },
                onLongPress: () {
                  tasksBox.deleteAt(int.parse(taskIndex.toString()));
                },
                child: Container(
                    child: Text(taskName.toString(),
                        style: TextStyle(fontSize: 30))))
          ],
        ));
  }

  Widget imageProv(String path) {
    AssetImage assetImage = AssetImage(path);
    Image image = Image(image: assetImage);
    return image;
  }

  void addNewTask({context, int? listId}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              "Add New Task",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      "Name of the Task",
                      style: TextStyle(fontSize: 25),
                    ),
                    hintText: ("Enter the Name of The Task..."),
                    hintStyle: TextStyle(fontSize: 25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  keyboardType: TextInputType.name,
                  controller: taskName,
                  maxLength: 100,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (taskName.text == '') taskName.text = "<No Name>";
                    Tasks? tasks = Tasks(
                      title: taskName.text,
                      isDone: false,
                      listIndex: listId,
                    );
                    tasksBox.add(tasks);
                    taskName.text = '';
                  },
                  child: Text("ADD Task", style: TextStyle(fontSize: 25)),
                ),
              ],
            ),
          );
        });
  }

  void editTask(context, int? listIndex, int? taskId) {
    taskName.text =
        (tasksBox.getAt(int.parse(taskId.toString()))?.title).toString();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text("Edit Task",style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                    label: Text(
                      "Name of the Task",
                      style: TextStyle(fontSize: 25),
                    ),
                    hintText: ("Enter the Name of The Task..."),
                    hintStyle: TextStyle(fontSize: 25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                    keyboardType: TextInputType.name,
                    controller: taskName,
                    maxLength: 100,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (taskName.text == '') taskName.text = "<No Name>";
                      Tasks? tasks = Tasks(
                        title: taskName.text,
                        isDone: false,
                        listIndex: listIndex,
                      );
                      tasksBox.putAt(int.parse(taskId.toString()), tasks);
                      taskName.text =
                          (tasksBox.getAt(int.parse(taskId.toString()))?.title)
                              .toString();
                    },
                    child: Text("EDIT",style: TextStyle(fontSize: 25)),
                  ),
                ],
              ));
        });
  }
}
