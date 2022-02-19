//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:flutter/material.dart';
import 'package:todo_application/HomePageBody.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/models/lists.dart';
import 'package:todo_application/models/tasks.dart';
import 'package:todo_application/widgets/widgetGetter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListsAdapter());
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Lists>("List Data Maintainer");
  await Hive.openBox<Tasks>("Task Data Maintainer");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "To-Do Application",
    theme: ThemeData(
        accentColor: Colors.amberAccent,
        fontFamily: "Dongle",
        brightness: Brightness.dark),
    home: HomeScreen(),
    //home: ListViewPage(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var listName = TextEditingController();
var listDesc = TextEditingController();
Box<Lists> listsBox = Hive.box<Lists>("List Data Maintainer");
Box<Tasks> tasksBox = Hive.box<Tasks>("Task Data Maintainer");

class _HomeScreenState extends State<HomeScreen> {
  var wg = WidgetGetter();

  @override
  void initState() {
    listsBox = Hive.box<Lists>("List Data Maintainer");
    tasksBox = Hive.box<Tasks>("Task Data Maintainer");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do App",
          style: TextStyle(fontFamily: 'Dongle', fontSize: 45),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          wg.addNewList(context);
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        tooltip: "Add new List",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: ViewOfHomePage(),
    );
  }
}
//