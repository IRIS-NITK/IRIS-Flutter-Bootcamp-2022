//Create a courses module in dart with two classes BranchElective and
//OpenElective with common fields being courseName and courseCode.
//BranchElective has two extra fields which are branch and year.
//The following features are to be implemented:
//An admin user can add courses(BranchElective, OpenElective) to the module
//A student can view branch electives based on his/her branch and year
//Any student can view open electives

import 'dart:io';

class BranchElective {
  var courseName = [];
  var courseCode = [];
  String branch = ""; //"CS", "IT" (For Example purposes only)
  int year = 0; //1, 2, 3, 4 (For Example purposes only)

  void valueGiver([String a = "", String b = ""]) {
    courseName.add(a);
    courseCode.add(b);
  }
}

class OpenElective {
  var courseName = [];
  var courseCode = [];

  void valueGiver([String a = "", String b = ""]) {
    courseName.add(a);
    courseCode.add(b);
  }
}

void yearAdmin(int year, String branch) {
  switch (year) {
    case 1:
      print('Enter Course Name: ');
      String? p = stdin.readLineSync()!;
      print('Enter Course Code: ');
      String? q = stdin.readLineSync()!;
      if (branch == "cs") cs1.valueGiver(p, q);
      if (branch == "it") it1.valueGiver(p, q);
      break;

    case 2:
      print('Enter Course Name: ');
      String? p = stdin.readLineSync()!;
      print('Enter Course Code: ');
      String? q = stdin.readLineSync()!;
      if (branch == "cs") cs2.valueGiver(p, q);
      if (branch == "it") it2.valueGiver(p, q);
      break;

    case 3:
      print('Enter Course Name: ');
      String? p = stdin.readLineSync()!;
      print('Enter Course Code: ');
      String? q = stdin.readLineSync()!;
      if (branch == "cs") cs3.valueGiver(p, q);
      if (branch == "it") it3.valueGiver(p, q);
      break;

    case 4:
      print('Enter Course Name: ');
      String? p = stdin.readLineSync()!;
      print('Enter Course Code: ');
      String? q = stdin.readLineSync()!;
      if (branch == "cs") cs4.valueGiver(p, q);
      if (branch == "it") it4.valueGiver(p, q);
      break;

    default:
      break;
  }
}

void yearStudent(int year, String branch) {
  switch (year) {
    case 1:
      if (branch == "cs") {
        int k = cs1.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${cs1.courseName[i]}   ${cs1.courseCode[i]}');
        }
      }
      if (branch == "it") {
        int k = it1.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${it1.courseName[i]}   ${it1.courseCode[i]}');
        }
      }
      break;

    case 2:
      if (branch == "cs") {
        int k = cs2.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${cs2.courseName[i]}   ${cs2.courseCode[i]}');
        }
      }
      if (branch == "it") {
        int k = it2.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${it2.courseName[i]}   ${it2.courseCode[i]}');
        }
      }
      break;

    case 3:
      if (branch == "cs") {
        int k = cs3.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${cs3.courseName[i]}   ${cs3.courseCode[i]}');
        }
      }
      if (branch == "it") {
        int k = it3.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${it3.courseName[i]}   ${it3.courseCode[i]}');
        }
      }
      break;

    case 4:
      if (branch == "cs") {
        int k = cs4.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${cs4.courseName[i]}   ${cs4.courseCode[i]}');
        }
      }
      if (branch == "it") {
        int k = it4.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${it4.courseName[i]}   ${it4.courseCode[i]}');
        }
      }
      break;

    default:
      break;
  }
}

var cs1 = BranchElective();
var cs2 = BranchElective();
var cs3 = BranchElective();
var cs4 = BranchElective();
var it1 = BranchElective();
var it2 = BranchElective();
var it3 = BranchElective();
var it4 = BranchElective();
var oe = OpenElective();

void main() {
  int? choice;

  do {
    print('Enter Type of User 1.Admin 2.Student 3.Exit');
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print('Enter Course Type 1.OpenElective 2.BranchElective');
        int? type = int.parse(stdin.readLineSync()!);

        switch (type) {
          case 1:
            print('Enter Course Name: ');
            String? a = stdin.readLineSync()!;
            print('Enter Course Code: ');
            String? b = stdin.readLineSync()!;

            oe.valueGiver(a, b);

            break;

          case 2:
            print('Enter Branch Name: ');
            String? bran = stdin.readLineSync()!;
            print('Enter Year: ');
            int? year = int.parse(stdin.readLineSync()!);
            yearAdmin(year, bran);
            break;

          default:
            break;
        }
        break;

      case 2:
        print('Enter Branch: ');
        String? br = stdin.readLineSync()!;
        print('Enter Year: ');
        int? yr = int.parse(stdin.readLineSync()!);

        print('List of Open Electives: ');
        int k = oe.courseName.length;
        for (int i = 0; i < k; i++) {
          print('${oe.courseName[i]}   ${oe.courseCode[i]}');
        }
        print();
        print('List of Branch Electives: ');
        yearStudent(yr, br);

        break;

      default:
        break;
    }
  } while (choice != 3);
}
