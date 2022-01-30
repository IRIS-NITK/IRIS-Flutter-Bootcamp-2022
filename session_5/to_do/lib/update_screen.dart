import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class UpdateScreen extends StatefulWidget {
  final String title, task, time;
  final DateTime date;
  final int index;
  const UpdateScreen(
      {Key? key,
      required this.title,
      required this.task,
      required this.date,
      required this.time,
      required this.index})
      : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List list = List.empty();
  TextEditingController titleController = TextEditingController(),
      taskController = TextEditingController();
  String yup = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  NumberFormat numberFormat = NumberFormat("00");
  DateFormat dateFormat = DateFormat('EEE, MMM d, ' 'yyyy');
  late CountdownTimerController ctr;

  int updateTime(DateTime date, String time) {
    int hour = 0, minute = 0;
    if (time.length > 10) {
      hour = int.parse(time.substring(10, 12));
      minute = int.parse(time.substring(13, 15));
    } else {
      hour = int.parse(time.substring(0, 2));
      minute = int.parse(time.substring(3, 5));
    }
    DateTime end = DateTime.parse(
        "${date.year}${numberFormat.format(date.month)}${numberFormat.format(date.day)}T${numberFormat.format(hour)}${numberFormat.format(minute)}00"
            .toString());
    int endTime = end.millisecondsSinceEpoch;
    return endTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    setState(() {});
    final TimeOfDay? got = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (got != null && got != selectedTime) {
      selectedTime = got;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    yup = widget.time;
    if (yup.length > 5) yup = yup.substring(10, 15);
    taskController.text = widget.task;
    titleController.text = widget.title;
    selectedDate = widget.date;
    selectedTime = TimeOfDay(
        hour: int.parse(yup.split(":")[0]),
        minute: int.parse(yup.split(":")[1]));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              stops: [0.1, 1.0],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            list = [...list, widget.title];
            list = [...list, widget.task];
            list = [...list, widget.date];
            list = [...list, selectedTime.toString().substring(10, 15)];
            Navigator.pop(context, list);
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                list = [...list, titleController.text];
                list = [...list, taskController.text];
                list = [...list, selectedDate];
                list = [...list, selectedTime.toString().substring(10, 15)];
                Navigator.pop(context, list);
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.date_range_outlined),
                  onPressed: () {
                    _selectDate(context);
                    setState(() {});
                  },
                ),
                Text(
                    dateFormat.format(selectedDate).toString() +
                        '\n${numberFormat.format(selectedTime.hour)}:' +
                        numberFormat.format(selectedTime.minute).toString(),
                    style: GoogleFonts.luckiestGuy(
                        fontSize: 20, fontWeight: FontWeight.w300)),
              ],
            ),
          )),
          Center(
            child: CountdownTimer(
              endTime: updateTime(selectedDate, selectedTime.toString()),
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  return Text('The due time has already passed!! :(',
                      style: GoogleFonts.oswald(
                          fontSize: 18, fontWeight: FontWeight.w500));
                }
                return Text(
                  'Days:${numberFormat.format(time.days ?? 0)}, hours:${numberFormat.format(time.hours ?? 0)}, min:${numberFormat.format(time.min ?? 0)}, sec:${numberFormat.format(time.sec ?? 0)}',
                  style: GoogleFonts.oswald(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.anton(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
              controller: titleController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                hintText: "Enter a title",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              maxLines: 4,
              style: GoogleFonts.copse(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
              controller: taskController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                hintText: "What do you want to do?",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
