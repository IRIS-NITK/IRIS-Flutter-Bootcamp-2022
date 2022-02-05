import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/tasks.dart';
import 'package:to_do_app/add_task.dart';
import 'package:to_do_app/update_task.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TasksList();
  }
}

class _TasksList extends State<TaskList> {
  bool flag = true;

  Container? main_body;

  FlutterLocalNotificationsPlugin? localNotification;

  Future _shownotification(String taskname, String remainingTime) async {
    var androidDetails = const AndroidNotificationDetails(
        "channelId", "Local Notification",
        importance: Importance.high);

    var iOSDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    if (remainingTime == "") {
      await localNotification!
          .show(0, taskname, "Task Has Been Ended", generalNotificationDetails);
    } else {
      await localNotification!.show(0, taskname,
          "24 Hrs left to complete the $taskname Task", generalNotificationDetails);
    }
  }

  @override
  void initState() {
    getTasks();

    super.initState();
    var androidInitialize = const AndroidInitializationSettings("notification");

    var iOSInitialize = const IOSInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    localNotification = FlutterLocalNotificationsPlugin();
    localNotification!.initialize(initializationSettings);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Task> listTasks = [];

  void getTasks() async {
    final box = await Hive.openBox<Task>('Task');
    if (box.isNotEmpty) {
      listTasks = box.values.toList();
      main_body = Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/main_bg.jpg"),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: listTasks.length,
              itemBuilder: (context, position) {
                Task getTask = listTasks[position];
                var date = getTask.date;
                var time = getTask.time;
                return Card(
                  elevation: 8,
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Row(children: [
                                  Text(getTask.desc,
                                      style: const TextStyle(
                                          fontSize: 20, fontFamily: "Alice")),
                                  Container(
                                    child: const Text("   "),
                                  ),
                                  Text(
                                      "( ${getremainingtime(date, time, getTask.desc)} )",
                                      style: const TextStyle(
                                          fontSize: 15, fontFamily: "Alice")),
                                ]))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 45),
                            child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => setState(() {
                                      {
                                        flag = true;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Update_Tasks(
                                                      position: position,
                                                      TaskModel: getTask,
                                                    )));
                                      }
                                    })),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                final box = Hive.box<Task>('Task');
                                box.deleteAt(position);
                                setState(() => {
                                      listTasks.removeAt(position),
                                      get_body(),
                                    });
                              }),
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("Date: $date | Time: $time",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Alice",
                                ))),
                      ],
                    ),
                  ),
                );
              }));
      setState(() {});
    } else {
      main_body = Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.1,
            ],
            colors: [
              Color.fromARGB(255, 36, 230, 230),
              Color.fromARGB(255, 116, 243, 84),
              Color.fromARGB(255, 245, 205, 97),
              Color.fromARGB(255, 247, 135, 107),
            ],
          )),
          alignment: Alignment.center, // use aligment
          // color: Color.fromARGB(255, 108, 248, 190),
          child: Column(
            children: [
              Image.asset('images/bg_lists.png',
                  height: 500, width: 380, fit: BoxFit.cover),
              const Padding(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Text("NO TASKS HAS BEEN ADDED YET",style: TextStyle(fontSize: 25,fontFamily: "Philosopher Italic",fontWeight: FontWeight.bold,color: Colors.black87)),
              ),
              const SizedBox(height: 70),
              Container(
                    margin: const EdgeInsets.only(
                        left: 70.0, top: 10.0, right: 70.0, bottom: 10.0),
                    height: 50,
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () {
                          
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CUD_Tasks()),
                              (r) => false);
                        
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color.fromARGB(255, 103, 245, 186), Color.fromARGB(255, 207, 118, 241)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "ADD  TASK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontFamily: "Cookie",
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ));

      setState(() {});
    }
  }

  // ignore: non_constant_identifier_names
  Container? get_body() {
    getTasks();
    setState(() {});
    return main_body;
  }

  String formatDuration(Duration d, String taskname) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    if (tokens.isNotEmpty || seconds != 0) {
      tokens.add('${seconds}s');
    }

    String remainingTime = tokens.join(':');

    if (days == 1 && hours == 0 && minutes == 0 && seconds == 0) {
      _shownotification("REMINDER", remainingTime);
    }

    if (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
      _shownotification(taskname, "");
    }

    return remainingTime;
  }

  String datetimediff(String date, String time, String taskname) {
    DateTime date1 = DateFormat.jm().parse(time);

    // ignore: non_constant_identifier_names
    String formated_time = DateFormat("HH:mm:ss").format(date1);

    String dt2 = "$date $formated_time";

    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dt2);
    var inputDate = DateTime.parse(parseDate.toString());

    DateTime currentDate = DateTime.now();

    Duration diff = inputDate.difference(currentDate);

    if (diff.isNegative) {
      return "0";
    } else {
      return formatDuration(diff, taskname);
    }
  }

  // ignore: non_constant_identifier_names
  String updatetime(String date, String time, String taskname) {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {});
      }
    });
    return datetimediff(date, time, taskname);
  }

  String getremainingtime(var date, var time, var desc) {
    String res = updatetime(date, time, desc);

    if (res == "0") {
      return " ✔️";
    }
    return "Ends in : $res";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text(
            "To-Do Application",
            style: TextStyle(fontFamily: "YesevaOne"),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 0.0, right: 20.0, bottom: 10.0),
              icon: const Icon(
                Icons.add,
                color: Colors.amberAccent,
                size: 40.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CUD_Tasks()));
              },
            ),
          ],
        ),
        body: get_body(),
      ),
    );
  }
}
