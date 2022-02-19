import "package:flutter/material.dart";
import 'package:todo_application/boxes.dart';
import 'package:todo_application/models/task.dart';


Future<void> addTaskDialog(BuildContext context, GlobalKey<FormState> formKey) async{
  return await showDialog(
    context: context, 
    builder: (context){
      final TextEditingController title = TextEditingController();
      final TextEditingController description = TextEditingController();
      final TextEditingController deadline = TextEditingController();
      bool? isChecked = false;
      DateTime date = DateTime.now();
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            scrollable: true,
            title: Column(
              children: const [
                Text("Add a Task",textAlign: TextAlign.center,),
                Divider(thickness: 5,)
              ],
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: title,
                    validator: (value){
                      return value!.isNotEmpty ? null:"Title not Specified";
                    },
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Enter the title of new task"
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                      labelText: "Description(Optional)",
                      hintText: "Enter the description of new task"
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: deadline,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Deadline not specified";
                      }
                      else if(date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString() == DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString()){
                        return "Deadline cannot be today";
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Deadline",
                      hintText: "Enter the deadline of new task"
                    ),
                    onTap: () async{
                      final DateTime? selected = await showDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                        context: context
                      );

                      if (selected != null && selected != date) {
                        setState(() {
                        date = selected;
                        deadline.text = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                      });
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Notify me"),
                      Checkbox(
                        activeColor: Colors.blue,
                        value: isChecked, 
                        onChanged: (checked){
                          setState((){
                            isChecked = checked;
                          });
                      }
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  if (formKey.currentState!.validate()){
                    addTask(title.text, description.text, date, isChecked);
                    Navigator.of(context).pop();
                  }
                }, 
                child: const Text("Add", style: TextStyle(fontSize: 17),))
            ],
          );
        }
      );
    }
  );
}
Future<void> editTaskDialog(BuildContext context, GlobalKey<FormState> formKey, Task task) async{
  return await showDialog(
    context: context, 
    builder: (context){
      DateTime date = task.deadline;
      final TextEditingController title = TextEditingController();
      title.text = task.title;
      final TextEditingController description = TextEditingController();
      description.text = task.description;
      final TextEditingController deadline = TextEditingController();
      deadline.text = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
      bool? isChecked = task.notify;
      
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            scrollable: true,
            title: Column(
              children: const [
                Text("Add a Task",textAlign: TextAlign.center,),
                Divider(thickness: 5,)
              ],
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    
                    controller: title,
                    validator: (value){
                      return value!.isNotEmpty ? null:"Title not Specified";
                    },
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Enter the title of new task"
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    
                    controller: description,
                    decoration: const InputDecoration(
                      labelText: "Description(Optional)",
                      hintText: "Enter the description of new task"
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
             
                    controller: deadline,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Deadline not specified";
                      }
                      else if(date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString() == DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString()){
                        return "Deadline cannot be today";
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Deadline",
                      hintText: "Enter the deadline of new task"
                    ),
                    onTap: () async{
                      final DateTime? selected = await showDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                        context: context
                      );

                      if (selected != null && selected != date) {
                        setState(() {
                        date = selected;
                        deadline.text = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                      });
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Notify me"),
                      Checkbox(
                        activeColor: Colors.blue,
                        value: isChecked, 
                        onChanged: (checked){
                          setState((){
                            isChecked = checked;
                          });
                      }
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  if (formKey.currentState!.validate()){
                    task.title = title.text;
                    task.description = description.text;
                    task.deadline = date;
                    task.notify = isChecked;
                    task.save();
                    Navigator.of(context).pop();
                  }
                }, 
                child: const Text("Edit", style: TextStyle(fontSize: 17),))
            ],
          );
        }
      );
    }
  );
}

Future addTask(String title,String description, DateTime deadline, bool? notify) async{
  final task = Task()
    ..title = title
    ..description = description
    ..deadline = deadline
    ..notify = notify;

  final box = Boxes.getTask();
  box.add(task);
}

void deleteTask(Task task){
  task.delete();
}