import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:schedule/widgets/events_widget.dart';

class editscreen extends StatefulWidget {
  editscreen({Key? key, required this.task,
    required this.i, required this.tasklist,
    required this.refreshlist})
      : date = task['date'].toString().split("/"),
        times = task['time'].toString().split(":"),
        titleCtrl = TextEditingController(text: task['title']),
        super(key: key){

    time = TimeOfDay(hour: int.parse(times[0].toString()), minute: int.parse(times[1].toString()));
    _dateTime = DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
}

  final task;
  final List date;
  final List times;
  final i;
  List tasklist;
  Function refreshlist;

  TimeOfDay? time;
  DateTime? _dateTime;

  final titleCtrl;

  @override
  _editscreenState createState() => _editscreenState();
}

class _editscreenState extends State<editscreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Edit Task", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),),
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
                        child: TextFormField(
                          controller: widget.titleCtrl,
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
                                (widget._dateTime?.day)! < 10 ? "0${widget._dateTime?.day.toString()}" : (widget._dateTime?.day.toString())!,
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
                                (widget._dateTime?.month)! < 10 ? "0${widget._dateTime?.month.toString()}" : (widget._dateTime?.month.toString())!,                                textAlign: TextAlign.center,
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
                                (widget._dateTime?.year.toString())!,
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
                                initialDate: (widget._dateTime)!,
                                firstDate: DateTime(1800),
                                lastDate: DateTime(3000)
                            );
                            if(_newDate != null){
                              setState(() {
                                widget._dateTime = _newDate;
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
                                widget.time!.hour < 10 ? "0${widget.time!.hour.toString()}" : widget.time!.hour.toString(),
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
                                widget.time!.minute < 10 ? "0${widget.time!.minute.toString()}" : widget.time!.minute.toString(),
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
                                initialTime: widget.time!
                            );
                            if(newTime != null){
                              setState(() {
                                widget.time = newTime;
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
                        widget.tasklist[widget.i] = {
                          'title': widget.titleCtrl.text,
                          'date': '${widget._dateTime?.day}/${widget._dateTime
                              ?.month}/${widget._dateTime?.year}',
                          'time': '${widget.time?.hour}:${widget.time?.minute}'
                        };

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

                        widget.refreshlist(newlist: widget.tasklist);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
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
