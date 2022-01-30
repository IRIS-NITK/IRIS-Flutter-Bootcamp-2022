import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@HiveType(typeId: 0)
class tasks {
  tasks({required this.task_deet, required this.deadline});

  @HiveField(0)
  String task_deet;

  @HiveField(1)
  String deadline;

  @override
  String toString() {
    return '$task_deet: $deadline';
  }
}

class user_task extends StatefulWidget {
  user_task({Key? key}) : super(key: key);

  @override
  State<user_task> createState() => user_taskState();
}

class user_taskState extends State<user_task> {
  final controller1 = TextEditingController();

  final controller2 = TextEditingController();
  List<String> p = [];
  List<String> t = [];

  String x = "";

  Future? add_task() async {
    var box = await Hive.openBox('tasks');
    box.put(controller1.text, controller2.text);
    String d = controller1.text + box.get(controller1.text);
    setState(() {
      x = "THIS TASK HAS BEEN ADDED ";
    });
    return controller1;
  }

  List disp() {
    var box = Hive.box('tasks');
    int k = box.length;
    int i = 0;
    var now = DateTime.parse('2020-01-02 03:04:05');
    for (i; i < k; i++) {
      p.add(box.keyAt(i));
      t.add("Time remaining- " +
          (DateTime.parse(box.getAt(i)).difference(DateTime.now())).toString());
    }
    print(now);
    return p;
  }

  List disp2() {
    var box = Hive.box('tasks');
    int k = box.length;
    int i = 0;
    var now;
    var finish;
    for (i; i < k; i++) {
      p.add(box.keyAt(i));
      t.add(box.getAt(i));
    }

    return t;
  }

  void del(String key) {
    var box = Hive.box('tasks');

    box.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "NEW TASK",
            style: const TextStyle(
                color: Color(0xFF303030), fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFFA5D6A7),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TASK TO BE COMPLETED',
              style: GoogleFonts.mcLaren(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                    hintText: "Task description",
                    hintStyle: GoogleFonts.mcLaren()),
              ),
            ),
            SizedBox(height: 30),
            Text("ENTER THE DEADLINE", style: GoogleFonts.mcLaren()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller2,
                decoration: InputDecoration(
                    hintText: "2020-01-02 03:04:05",
                    hintStyle: GoogleFonts.mcLaren()),
              ),
            ),
            SizedBox(height: 50),
            OutlinedButton(
              onPressed: add_task,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
              child: Text(
                "ADD TASK",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Text(x, style: GoogleFonts.mcLaren()),
          ],
        ),
      ),
    );
  }
}
