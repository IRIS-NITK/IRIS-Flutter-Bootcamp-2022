import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:remind_me/Models/tasks.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var date = DateTime.now();
  var time = DateTime.now();
  var taskName = TextEditingController();

  void DatePick(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      date = args.value;
    });
  }

  void AddTask() async {
    var b = Hive.box<Tasks>('Tasks');
    var t = Tasks(task: taskName.text, date: date, time: time);
    var a = await b.add(t);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Task"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Task Name",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: taskName,
                      style: TextStyle(fontSize: 35.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text("Deadline Date",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SfDateRangePicker(
                      enablePastDates: false,
                      onSelectionChanged: DatePick,
                      initialSelectedDate: date,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Deadline Time",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                    TimePickerSpinner(
                      isForce2Digits: true,
                      is24HourMode: false,
                      onTimeChange: (t) {
                        setState(() {
                          time = t;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextButton(
                        onPressed: AddTask,
                        child: const Text(
                          "OK",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 20.0),
                        ))
                  ])),
        ));
  }
}
