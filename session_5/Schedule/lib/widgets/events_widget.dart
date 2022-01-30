import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:schedule/screens/edit_screen.dart';

List tasklist = [];

class EventList extends StatefulWidget {
  EventList({Key? key, required this.listoftask}) : super(key: key) {
    tasklist = listoftask;
  }
  final listoftask;

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  void refreshList({List? newlist}) async{
    var box = await Hive.openBox('task');
    await box.put('tasks', newlist ?? tasklist);

    setState(() {

    });
  }

  void editlist(int i)
  {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return editscreen(tasklist: tasklist, task: tasklist[i], i: i, refreshlist: refreshList);
        }

        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasklist.length,
        itemBuilder:  (context, i) => EventCard(
            title: tasklist[i]['title'],
            date: tasklist[i]['date'],
            time: tasklist[i]['time'],
          i: i,
          refreshlist: refreshList,
          editlist: editlist,
        )

    );;
  }
}


class EventCard extends StatefulWidget {
  EventCard({Key? key, required this.title, required this.date, required this.time, required this.i, required this.refreshlist, required this.editlist}) : super(key: key){
    calcTime();
  }

  final String title;
  String date;
  String time;
  final i;
  String time_remaining = "";
  Function refreshlist;
  Function editlist;

  void calcTime()
  {
    List dates = date.split("/");
    List times = time.split(":");

    time = '';                          //formatting
    date = '';
    if(int.parse(times[0]) < 10){
      time = '0';
    }
    time += times[0] + ':';

    if(int.parse(times[1]) < 10){
      time += '0';
    }
    time += times[1];


    if(int.parse(dates[0]) < 10){
      date = '0';
    }
    date += dates[0] + '/';

    if(int.parse(dates[1]) < 10){
      date += '0';
    }
    date += dates[1] + '/' + dates[2];


    var now = DateTime.now();

    if(now.year == int.parse(dates[2])){
      if(now.month == int.parse(dates[1])){
        if(now.day == int.parse(dates[0])){
          if(now.hour < int.parse(times[0])){
            var timediff = (int.parse(times[0]) - now.hour) * 60 + (int.parse(times[1]) - now.minute);
            time_remaining = "${timediff ~/ 60}Hrs ${timediff % 60}mins";
          }
          else{
            time_remaining = "Expired!";
          }
        }
        else if(now.day < int.parse(dates[0])){
          var timediff = (int.parse(dates[0]) - now.day) * 24 + (int.parse(times[0]) - now.hour);
          time_remaining = "${timediff ~/ 24}Days ${timediff % 24}hrs";
        }
        else{
          time_remaining = "Expired!";
        }
      }
      else if(now.month < int.parse(dates[1])){
        var timediff = (int.parse(dates[1]) - now.month) * 30 + (int.parse(dates[0]) - now.day);
        time_remaining = "${timediff ~/ 30}Mons ${timediff % 30}days";
      }
      else{
        time_remaining = "Expired!";
      }
    }
    else if(now.year < int.parse(dates[2])){
      var timediff = (int.parse(dates[2]) - now.year) * 365 + (int.parse(dates[1]) - now.month);
      time_remaining = "${timediff ~/ 365}Yrs ${timediff % 365}mons";
    }
    else{
      time_remaining = "Expired!";
    }
  }

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              Text(
                widget.time_remaining,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: (widget.time_remaining == "Expired!") ? Colors.red : Colors.green
                ),
              )
            ],
          ),
          subtitle: Row(
            children: [
              Text(
                widget.date
              ),
              const SizedBox(
                width: 100,
              ),
              Text(
                widget.time
              )
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text(
                    'Edit'
                  ),
                 onPressed: (){
                    widget.editlist(widget.i);
                 },
                ),
                TextButton(
                  child: const Text(
                    'Delete'
                  ),
                  onPressed: (){
                    tasklist.removeAt(widget.i);
                    widget.refreshlist();
                    }
                    )
            ]
            )
          ],
        ),
    )
    );
  }
}
