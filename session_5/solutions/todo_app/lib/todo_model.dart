import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel{
  @HiveField(0)
  String title;
  @HiveField(1)
  var date;
  @HiveField(2)
  var time;


  TodoModel({required this.title,required this.date,required this.time});

}