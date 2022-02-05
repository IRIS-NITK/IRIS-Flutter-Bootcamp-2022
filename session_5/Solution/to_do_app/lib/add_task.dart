// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/tasks.dart';
import 'package:to_do_app/task_list.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types, must_be_immutable
class CUD_Tasks extends StatefulWidget {
  const CUD_Tasks({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddEditTaskState();
  }
}

class AddEditTaskState extends State<CUD_Tasks> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController controllerdesc = TextEditingController();
  TextEditingController controllerdate = TextEditingController();
  TextEditingController controllertime = TextEditingController();

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        controllertime.text = formatTimeOfDay(selectedTime);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controllerdate.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            backgroundColor : Colors.tealAccent,
              body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: const DecorationImage(
                    image: AssetImage("images/addtask.jpg"),
                    fit: BoxFit.cover,
                  )),
              margin: const EdgeInsets.only(
                  top: 180, left: 25, right: 25, bottom: 180),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("TASK DESC :", style: TextStyle(fontSize: 15,fontFamily: "Philosopher Italic",fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Alice",
                                fontSize: 20),
                            cursorColor: Colors.white,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Task Description!!!";
                              }
                            },
                            controller: controllerdesc),
                      )
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("TASK END DATE :",
                          style: TextStyle(fontSize: 15,fontFamily: "Philosopher Italic",fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Alice",
                              fontSize: 20),
                          cursorColor: Colors.white,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter The Task End Date!!!";
                            }
                          },
                          onTap: () => _selectDate(context),
                          controller: controllerdate,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("TASK END TIME :",
                          style: TextStyle(fontSize: 15,fontFamily: "Philosopher Italic",fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Alice",
                              fontSize: 20),
                          cursorColor: Colors.white,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter The Task End Time!!!";
                            }
                          },
                          onTap: () => _selectTime(context),
                          controller: controllertime,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 100),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 70.0, top: 10.0, right: 70.0, bottom: 10.0),
                    height: 50,
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var getTaskdesc = controllerdesc.text;
                          var getTaskdate = controllerdate.text;
                          var getTasktime = controllertime.text;
                          if (getTaskdesc.isNotEmpty &
                              getTaskdate.isNotEmpty &
                              getTasktime.isNotEmpty) {
                            Task addTask = Task(
                                desc: getTaskdesc,
                                date: getTaskdate,
                                time: getTasktime);
                            var box = await Hive.openBox<Task>('Task');
                            box.add(addTask);
                          }
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const TaskList()),
                              (r) => false);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.pink],
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
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "Cookie",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
