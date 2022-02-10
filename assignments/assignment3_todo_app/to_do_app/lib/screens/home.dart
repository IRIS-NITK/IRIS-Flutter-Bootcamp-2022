import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/adapter/todo_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Todo> listTodos = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings? androidInitializationSettings;
  IOSInitializationSettings? iosInitializationSettings;
  InitializationSettings? initializationSettings;

  void getTodos() async {
    final todoBox = await Hive.openBox<Todo>('todos');

    setState(() {
      listTodos = todoBox.values.toList();
    });
  }

  @override
  void initState() {
    // Provider.of<NotificationService>;
    getTodos();

    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    iosInitializationSettings = const IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings!,
        onSelectNotification: onSelectNotification);
  }

  void _showNotification(String title) async {
    await notification(title);
  }

  Future<void> notification(String title) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel Id', 'Channel Name',
            channelDescription: 'Channel Body',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');
    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0,
        'Reminder: Only 24 hours left!! ', 'Task: $title', notificationDetails);
  }

  Future onSelectNotification(String? payload) async {}
  void fun() {
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("ToDo App", style: GoogleFonts.robotoSlab(fontSize: 24))),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return const Center(
                child: Text("No data available",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          }

          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo todo = box.getAt(index)!;
                int timeCount = todo.dateTime.millisecondsSinceEpoch;

                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      shape: BoxShape.rectangle),
                  child: ListTile(
                    title: Text(todo.title,
                        style: GoogleFonts.robotoSlab(
                            fontSize: 22,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todo.description,
                            style: GoogleFonts.quintessential(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 231, 73, 126),
                                fontWeight: FontWeight.bold)),
                        const Padding(padding: EdgeInsets.all(2)),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.purple,
                              shape: BoxShape.rectangle),
                          child: CountdownTimer(
                              endTime: timeCount,
                              widgetBuilder:
                                  (_, CurrentRemainingTime? timeCount) {
                                if (timeCount == null) {
                                  //setState(() {});
                                  todo.completionStatus = true;
                                  fun();
                                  return Text('Completed',
                                      style: GoogleFonts.ptSerif(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                } else {
                                  if (timeCount.days == 1 &&
                                      timeCount.hours == 0 &&
                                      timeCount.min == 0 &&
                                      timeCount.sec == 0) {
                                    debugPrint(
                                        "Now the time ends for this task");
                                    _showNotification(todo.title);
                                  }
                                  return Text(
                                      '${timeCount.days ?? 0}d : ${timeCount.hours ?? 0}h : ${timeCount.min ?? 0}m : ${timeCount.sec ?? 0}s',
                                      style: GoogleFonts.ptSerif(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                }
                              }),
                        ),
                      ],
                    ),
                    leading: todo.completionStatus
                        ? Container(
                            decoration: const BoxDecoration(
                                color: Colors.purple, shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.done,
                                    color: Colors.white)),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                                color: Colors.purple, shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  if (todo.completionStatus) {
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.access_time_outlined,
                                    color: Colors.white)),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.purple),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddTodo(true, index, todo);
                                },
                                barrierDismissible: false);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 231, 73, 126),
                          ),
                          onPressed: () {
                            box.deleteAt(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTodo(false, 0, null);
              },
              barrierDismissible: false);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
