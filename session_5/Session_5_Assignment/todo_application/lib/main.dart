import 'package:flutter/material.dart';
import 'package:todo_application/add_task.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_application/boxes.dart';
import 'dart:io';

import 'package:todo_application/models/task.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose(){
    Hive.close();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editKey = GlobalKey<FormState>();

  // List test = [{"Title":"Title 1","Subtitle":"This is Title 1",},{"Title":"Title 2","Subtitle":"This is Title 2",}];

  dynamic date = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text(
          'DO NOT FORGET !!!',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await addTaskDialog(context,_formKey);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<Task>>(
          valueListenable: Boxes.getTask().listenable(),
          builder: (context, box, _){
            final tasks = box.values.toList().cast<Task>();

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(tasks[index].title),
                        subtitle: Text(tasks[index].description),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          Text("Days Left: "+tasks[index].deadline.difference(DateTime.now()).inDays.toString()+" days",),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: ()async{
                              await editTaskDialog(context, _editKey, tasks[index]);
                            }, 
                            child: Row(children: const[Icon(Icons.edit), Text("Edit", style: TextStyle(fontSize: 17),)],),
                          ),
                          TextButton(
                            onPressed: () => deleteTask(tasks[index]), 
                            child: Row(children: const[Icon(Icons.delete), Text("Delete", style: TextStyle(fontSize: 17),)],),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        // child: ListView.builder(
        //   itemCount: test.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       child: ListTile(
        //         title: Text(test[index]['Title']),
        //         subtitle: Text(test[index]['Subtitle']),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}