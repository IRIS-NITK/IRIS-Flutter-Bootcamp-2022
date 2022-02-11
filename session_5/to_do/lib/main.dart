import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'home.dart';

Future<void> main() async {
  AwesomeNotifications().initialize('resource://drawable/todo', [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'notifiy',
        defaultColor: Colors.purple[50],
        importance: NotificationImportance.High,
        channelShowBadge: true)
  ]);
  await Hive.initFlutter();
  await Hive.openBox('taskBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        theme: ThemeData(
          textTheme: GoogleFonts.copseTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ));
  }
}
