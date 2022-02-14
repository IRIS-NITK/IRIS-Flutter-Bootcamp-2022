import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/tasks.dart';
import 'widgets/boxes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('Tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Planner',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      home: const TaskView(),
    );
  }
}

class TaskView extends StatefulWidget {
  const TaskView({ Key? key }) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  late Box<Tasks> TaskBox;
  
  final MyController1 = TextEditingController();
  final MyController2 = TextEditingController();

  Future MakeEntry() async
  {
    final Task = Tasks();
      Task.task = MyController1.text;
      Task.deadline = MyController2.text;
      Task.timeleft = 0;

    TaskBox.add(Task);
  }

  @override
  void initState()
  {
    super.initState();
    TaskBox = Hive.box<Tasks>("Tasks");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
      ),

      body: Column(
        children:  <Widget>[
          const SizedBox(height: 12),
          ValueListenableBuilder(
            valueListenable: TaskBox.listenable(),
            builder: (context, Box<Tasks> TaskViewer, _){
              List<int> keys = TaskBox.keys.cast<int>().toList();
              return ListView.separated(
                itemBuilder: (_, index){
                  final int key = keys[index];
                  final Tasks tasklist = TaskViewer.get(key) as Tasks;
                  return Card(
                    child: ListTile(
                      title: Text(
                        tasklist.task,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        tasklist.deadline,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      leading: const Icon(
                        Icons.task_rounded,
                        color: Colors.green,
                      ),
                      onTap: (){
                        showDialog(
                          builder:(context) => Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:  <Widget>[
                                  const SizedBox(height: 20.0),
                                  const SizedBox(width: 30.0),
                                  TextButton(
                                    onPressed: (){
                                      TaskBox.delete(key);
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      size: 35.0,
                                    ),
                                  ),
                                  const SizedBox(width: 60.0),
                                  TextButton(
                                    onPressed: (){
                                      showDialog(
                                        builder:(context) => Dialog(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:  <Widget>[
                    
                                                TextField(
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: "Enter the task",  
                                                  ),
                                                  controller: MyController1,
                                                  keyboardType: TextInputType.text,
                                                  textAlign: TextAlign.center,  
                                                ),

                                                const SizedBox(height:30),
                                                TextField(
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: "Enter the deadline",
                                                  ),
                                                controller: MyController2,
                                                keyboardType: TextInputType.text,
                                                textAlign: TextAlign.center,
                                                ),

                                                const SizedBox(height:20),
                                                TextButton(
                                                  onPressed: (){
                                                    late Tasks editTask = tasklist;
                                                    editTask.task=MyController1.text;
                                                    editTask.deadline=MyController2.text;
                                                    TaskBox.add(editTask);
                                                    Navigator.pop(context);
                                                    setState(() {
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.edit_rounded,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ]
                                            ),
                                          )
                                        ),
                                        context: context,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      size: 30.0,
                                    )
                                  ),
                                ]
                              ),
                            )
                          ),
                          context: context,
                        );
                      },
                    ),
                    color: Colors.greenAccent,
                  );
                }, 
                separatorBuilder: (_, index) => const Divider(height: 8.0,), 
                itemCount: keys.length,
                shrinkWrap: true,
              );    
            },
          ),

          Row(
            children: <Widget>[
              const SizedBox(
                width: 165.0
              ),
              TextButton(
                onPressed: (){
                  showDialog(
                    builder: (context) => Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  <Widget>[
                    
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter the task",  
                              ),
                              controller: MyController1,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,  
                            ),

                            const SizedBox(height:30),
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter the deadline",
                              ),
                              controller: MyController2,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height:20),
                            TextButton(
                              onPressed: (){
                                MakeEntry();
                                Navigator.pop(context);
                              },
                              child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              ),
                            )
                          ]
                        ),
                      )
                    ), context: context,
                 );
                }, 
                
                child: const Icon(
                  Icons.add_rounded,
                  size: 50.0,
                ),
              ),
            ],
          ),

        ],
      )
    );  
  }
}
