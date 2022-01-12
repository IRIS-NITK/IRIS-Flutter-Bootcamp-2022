// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable, unused_import

import 'package:solution_4/solution_4.dart' as solution_4;
import 'dart:io';
import 'dart:math';
import 'dart:convert';

void Admin() {
  List<String> open_elctives = [];
  List<String> branch_electives = [];
  List<String> branch_year = [];
  print('Enter course type: 1.Open elective 2.Branch elective');
  int? n = int.parse(stdin.readLineSync()!);
  if (n == 1) {
    print('Enter course name and code:');
    String? s = stdin.readLineSync();
    open_elctives.add(s.toString());
  } else {
    print('Enter branch, year: ');
    String? d = stdin.readLineSync();
    branch_year.add(d.toString());
    print('Enter course name and code:');
    String? s = stdin.readLineSync();
    open_elctives.add(s.toString());
  }
}

void Student() {
  List<String> open_elctives = [];
  List<String> branch_electives = [];
  List<String> branch_year = [];
  print('Enter branch and year');
  String? s = stdin.readLineSync();
  if (branch_electives != null || open_elctives != null) {
    print(open_elctives);
    print(branch_electives);
  } else {
    print('list of open electives');
    print('list of branch electives');
  }
}

void main(List<String> arguments) {
  List<String> branch_year = [];
  List<String> open_elctives = [];
  List<String> branch_electives = [];
  int p = 1;
  do {
    print('Enter type of user: 1.Admin 2.student');
    int? n = int.parse(stdin.readLineSync()!);
    n == 1 ? Admin() : Student();
    print("press 0 to exit, else 1");
    int? p = int.parse(stdin.readLineSync()!);
    if (p != 1) {
      break;
    }
  } while (p == 1);
}
