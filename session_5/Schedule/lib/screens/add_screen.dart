import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class addscreen extends StatefulWidget {
  addscreen({Key? key, required this.tasklist, required this.refreshlist}) : super(key: key);

  List tasklist;
  Function refreshlist;


  @override
  _addscreenState createState() => _addscreenState();
}

class _addscreenState extends State<addscreen> {


  final titleCtrl = TextEditingController();

  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 10);
  DateTime _dateTime = DateTime(2022);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),),
        backgroundColor: Colors.amber
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Task name",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          height: 100,
                          child: TextField(
                            controller: titleCtrl,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            "Deadline",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _dateTime.day < 10 ? "0${_dateTime.day.toString()}" : _dateTime.day.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                          ),
                        ),
                        const Text(" / "),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _dateTime.month < 10 ? "0${_dateTime.month.toString()}" : _dateTime.month.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                          ),
                        ),
                        const Text(" / "),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: SizedBox(
                              width: 70,
                              height: 45,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _dateTime.year.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FloatingActionButton(
                          mini: true,
                            child: const Icon(
                              Icons.date_range,
                            ),
                            onPressed: () async {
                              DateTime? _newDate = await showDatePicker(
                                  context: context,
                                  initialDate: _dateTime,
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(3000)
                              );
                              if(_newDate != null){
                                setState(() {
                                  _dateTime = _newDate;
                                });
                              }
                            }

                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          width: 60
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                time!.hour < 10 ? "0${time!.hour.toString()}" : time!.hour.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ),
                        ),
                        const Text(" : "),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                time!.minute < 10 ? "0${time!.minute.toString()}" : time!.minute.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                            mini: true,
                            child: const Icon(
                                Icons.access_time_outlined,
                            ),
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: time!
                              );
                              if(newTime != null){
                                setState(() {
                                  time = newTime;
                                });
                              }
                            }
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    OutlinedButton(
                        onPressed: () async{
                          widget.tasklist.add(
                              {'title': titleCtrl.text,
                                'date': '${_dateTime.day}/${_dateTime
                                    .month}/${_dateTime.year}',
                                'time': '${time?.hour}:${time?.minute}'
                              }
                          );

                          widget.tasklist.sort(
                                  (a, b) {
                                List a_dates = a['date'].toString().split("/");
                                List a_times = a['time'].toString().split(":");
                                List b_dates = b['date'].toString().split("/");
                                List b_times = b['time'].toString().split(":");

                                DateTime a_date = DateTime(int.parse(a_dates[2]), int.parse(a_dates[1]), int.parse(a_dates[0]),
                                    int.parse(a_times[0]), int.parse(a_times[1])
                                );
                                DateTime b_date = DateTime(int.parse(b_dates[2]), int.parse(b_dates[1]), int.parse(b_dates[0]),
                                    int.parse(b_times[0]), int.parse(b_times[1])
                                );

                                return a_date.compareTo(b_date);
                              }
                          );

                          var box = await Hive.openBox('task');
                          await box.put('tasks', widget.tasklist);

                          widget.refreshlist(widget.tasklist);

                          Navigator.pop(context);
                        },
                        child: const Text(
                            "Add task to schedule",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.green,
                            color: Colors.white
                          ),
                        ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                    )
                  ],
                ),
          ),
        ),
      )

    );
  }
}
