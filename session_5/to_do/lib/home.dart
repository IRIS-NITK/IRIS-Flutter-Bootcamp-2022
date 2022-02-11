import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'update_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List dates = Hive.box("taskBox").get("dates", defaultValue: []);
  static List times = Hive.box("taskBox").get("times", defaultValue: []);
  static List tasks = Hive.box("taskBox").get("tasks", defaultValue: []);
  static List titles = Hive.box("taskBox").get("titles", defaultValue: []);
  List<bool> _selected = [];
  List<CountdownTimerController> controller = [];
  TextEditingController titleController = TextEditingController(),
      taskController = TextEditingController();
  bool notEmpty = false;
  BoxDecoration boxdec = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient:
        const LinearGradient(colors: [Colors.deepPurple, Colors.lightBlue]),
  );
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  DateFormat dateFormat = DateFormat('dd MMM ,' 'yyyy');
  NumberFormat numberFormat = NumberFormat("00");
  TimeOfDay selectedTime = TimeOfDay.now();
  late CountdownTimerController ctr;

  int updateTime(DateTime date, String time) {
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3, 5));
    DateTime end = DateTime.parse(
        "${date.year}${numberFormat.format(date.month)}${numberFormat.format(date.day)}T${numberFormat.format(hour)}${numberFormat.format(minute)}00"
            .toString());
    int endTime = end.millisecondsSinceEpoch;
    return endTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    setState(() {});
    final TimeOfDay? got = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (got != null && got != selectedTime) {
      selectedTime = got;
    }
    setState(() {});
  }

  Future<void> updateBox() async {
    var box = Hive.box('taskBox');
    await box.put('tasks', tasks);
    await box.put('titles', titles);
    await box.put('dates', dates);
    await box.put('times', times);
  }

  void addToList() {
    String s1 = titleController.text;
    String s2 = taskController.text;
    titles = [s1, ...titles];
    tasks = [s2, ...tasks];
    _selected = [false, ..._selected];
    dates = [selectedDate, ...dates];
    times = [selectedTime.toString().substring(10, 15), ...times];
    updateBox();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    titleController.text = "";
    taskController.text = "";
    setState(() {});
  }

  void deleteTask(var index) {
    tasks.removeAt(index);
    titles.removeAt(index);
    _selected.removeAt(index);
    dates.removeAt(index);
    times.removeAt(index);
    updateBox();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((value) {
      if (!value) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text('Allow Notifications'),
                    content: const Text(
                        'Our App would like to remind you about your tasks through notifications'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Don\'t Allow',
                            style:
                                TextStyle(color: Colors.red[200], fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () => AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((value) => Navigator.pop(context)),
                          child: Text(
                            'Allow',
                            style: TextStyle(
                                color: Colors.blue[200],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))
                    ]));
      }
    });
    controller =
        List.filled(tasks.length + 1, CountdownTimerController(endTime: 0));
    _selected = List.filled(tasks.length, false, growable: true);
  }

  void updateText(
      String title, String task, DateTime date, String time, int index) {
    titles[index] = title;
    tasks[index] = task;
    dates[index] = date;
    times[index] = time;
    updateBox();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.blue],
                stops: [0.1, 1.0],
              ),
            ),
          ),
          title: Text("To Do List",
              style: GoogleFonts.permanentMarker(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300))),
      body: (tasks.isEmpty)
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset(
                "assets/default.png",
                fit: BoxFit.contain,
              ),
            ))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AnimatedOpacity(
                      opacity: _selected[index] ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 700),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.green,
                            Colors.deepPurple,
                            Colors.blue
                          ]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: ExpansionTile(
                            children: <Widget>[
                              Center(
                                child: CountdownTimer(
                                  endTime:
                                      updateTime(dates[index], times[index]),
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time?.days == null || time?.days == 0) {
                                      if (time?.hours == 23 &&
                                          time?.min == 59 &&
                                          time?.sec == 59) {
                                        onedayNotifications(titles[index]);
                                      } else if (time?.hours == null &&
                                          time?.days == null &&
                                          time?.min == 59 &&
                                          time?.sec == 59) {
                                        onehourNotifications(titles[index]);
                                      }
                                    }
                                    if (time == null) {
                                      return Text(
                                          'The due time has already passed!! :(',
                                          style: GoogleFonts.oswald(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500));
                                    }
                                    return Text(
                                      'Days:${numberFormat.format(time.days ?? 0)}, hours:${numberFormat.format(time.hours ?? 0)}, min:${numberFormat.format(time.min ?? 0)}, sec:${numberFormat.format(time.sec ?? 0)}',
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                            title: Text(
                              titles[index],
                              style: (DateTime.now().isAfter(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          updateTime(
                                              dates[index], times[index]))))
                                  ? GoogleFonts.anton(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2.7,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                    )
                                  : GoogleFonts.anton(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                    ),
                            ),
                            subtitle: Text(
                              (tasks[index].length > 15 ||
                                      tasks[index].contains('\n'))
                                  ? tasks[index]
                                          .toString()
                                          .trim()
                                          .replaceAll('\n', ' ')
                                          .substring(
                                              0,
                                              min(
                                                  tasks[index].trim().length -
                                                      1,
                                                  35)) +
                                      "........"
                                  : tasks[index],
                              style: (DateTime.now().isAfter(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          updateTime(
                                              dates[index], times[index]))))
                                  ? GoogleFonts.copse(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2.3,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    )
                                  : GoogleFonts.copse(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                            ),
                            leading: IconButton(
                              padding: const EdgeInsets.only(left: 0),
                              icon: _selected[index]
                                  ? const Icon(Icons.check_circle_sharp)
                                  : const Icon(
                                      Icons.check_circle_outline_sharp,
                                    ),
                              iconSize: 30,
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _selected[index] = !_selected[index];
                                });
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  setState(() {
                                    deleteTask(index);
                                  });
                                });
                                setState(() {});
                              },
                            ),
                            trailing: IconButton(
                              icon:
                                  const Icon(Icons.mode_edit_outline_outlined),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateScreen(
                                          title: titles[index],
                                          task: tasks[index],
                                          date: dates[index],
                                          time: times[index],
                                          index: index)),
                                );
                                ScaffoldMessenger.of(context).setState(() {
                                  updateText(result[0], result[1], result[2],
                                      result[3], index);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 60,
          height: 60,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue])),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox.expand(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.date_range_outlined)),
                            Text(
                              dateFormat.format(selectedDate).toString() +
                                  ' ${numberFormat.format(selectedTime.hour)}:' +
                                  numberFormat.format(selectedTime.minute),
                              style: GoogleFonts.luckiestGuy(),
                            )
                          ],
                        ),
                        TextField(
                          controller: titleController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            hintText: "Enter the title",
                          ),
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          controller: taskController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            hintText: "What do you want to do?",
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: boxdec,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: const EdgeInsets.all(20)),
                                  onPressed: () {
                                    if (titleController.text != "" &&
                                        taskController.text != "") {
                                      addToList();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Add")),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              decoration: boxdec,
                              child: ElevatedButton(
                                child: const Text("Close"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.all(20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        tooltip: 'increment',
      ),
    );
  }
}
