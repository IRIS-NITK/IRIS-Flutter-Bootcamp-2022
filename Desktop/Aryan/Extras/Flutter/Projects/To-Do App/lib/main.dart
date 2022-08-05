import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("tasksBox");
  runApp(MaterialApp(home: MyApp(),title: "To-Do App",debugShowCheckedModeBanner: false));
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _Controller = TextEditingController();
  late Box tasks;
  @override
  void initState() {
    super.initState();
    tasks = Hive.box("tasksBox");
  }

  void Delete(int index) {
    setState(() {
      tasks.deleteAt(index);
      return;
    });
  }
  void AddTask() {
    if (_Controller.text.isNotEmpty) {
      setState(() {
        tasks.add(_Controller.text);
      });
      Navigator.pop(context);
      _Controller.clear();
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: ()=>showDialog(
              context: context, builder: (context){
            return AlertDialog(
              title: Text('Add New Task'),
              content: TextField(
                  controller: _Controller,
                  decoration: InputDecoration(hintText: "Enter task"),
                  autofocus: true),
              actions: <Widget>[
                TextButton(
                  child: Text('ADD'),
                  onPressed: () => AddTask(),
                ),
              ],
            );
          }
          ),
        ),
        appBar: AppBar(title: Text("To-Do App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),centerTitle: true,shadowColor: Colors.black,backgroundColor: Colors.green,),
        body:new ListView.builder(
          itemCount:tasks.length,
          itemBuilder: (context,i){
            print(tasks.getAt(i));
            return ListTile(
              title: Text(tasks.getAt(i)),
            trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => Delete(i),
            ),
            );
          }
        )
      );
  }
}


