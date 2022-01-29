import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_hive_getx/app/modules/home/widgets/task_widget.dart';
import 'package:task_manager_hive_getx/app/shared/models/task.dart';
import 'package:task_manager_hive_getx/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTasks(),
      builder: (context, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return (Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Text(
                    'What\'s up for Today?',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                                title: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter task name'),
                                  onSubmitted: (value) {
                                    Navigator.pop(context);
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onConfirm: (date) {
                                      if (value.isNotEmpty) {
                                        var task = Task.create(
                                            name: value, createdAt: date);
                                        base.dataStore.addTask(task: task);
                                      }
                                    }, currentTime: DateTime.now());
                                  },
                                  autofocus: true,
                                ),
                                trailing: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.alarm))),
                          );
                        });
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              var task = tasks[index];
              return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('This task was deleted',
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  onDismissed: (direction) {
                    base.dataStore.deleteTask(task: task);
                  },
                  key: Key(task.id),
                  child: TaskWidget(task: tasks[index]));
            },
          ),
        ));
      },
    );
  }
}
