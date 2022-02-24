library electives;

import 'dart:io';

class BranchElective {
  String courseName = "", courseCode = "", branch = "";
  int year = 0;
  BranchElective(String name, String code, String br, int yr) {
    courseName = name;
    courseCode = code;
    branch = br;
    year = yr;
  }
  String toString() {
    String str = "$courseName \t $courseCode";
    return str;
  }

  String getName() {
    return courseName;
  }

  String getCode() {
    return courseCode;
  }

  String getBranch() {
    return branch;
  }

  int getYear() {
    return year;
  }
}

class OpenElective {
  String courseName = "", courseCode = "";

  OpenElective(String name, String code) {
    courseName = name;
    courseCode = code;
  }
  String getName() {
    return courseName;
  }

  String getCode() {
    return courseCode;
  }

  String toString() {
    String str = "$courseName \t $courseCode";
    return str;
  }
}

void main() {
  List<BranchElective> branch = [];
  List<OpenElective> open = [];
  int choice1, choice2;
  do {
    print("MENU :");
    print('1.Admin');
    print('2.Student');
    print('Any other number for EXit');
    choice1 = int.parse(stdin.readLineSync()!);
    switch (choice1) {
      case 1:
        print('Enter course type');
        print('1.Branch Elective');
        print('2.Open Elective');
        choice2 = int.parse(stdin.readLineSync()!);
        if (choice2 == 1) {
          print(
              'Enter CourseName, CourseCode, Branch(2-letter code) and Year(1-4)');
          String? str = stdin.readLineSync()!;
          var spl = str.split(" ");
          BranchElective br = new BranchElective(spl.elementAt(0),
              spl.elementAt(1), spl.elementAt(2), int.parse(spl.elementAt(3)));
          branch.add(br);
          print('Added the course :)');
        } else {
          print('Enter CourseName, CourseCode');
          String? str = stdin.readLineSync()!;
          var spl = str.split(" ");
          OpenElective op =
              new OpenElective(spl.elementAt(0), spl.elementAt(1));
          open.add(op);
          print('Added the course :)');
        }
        break;
      case 2:
        print('Enter branch(2-letter code) and year(1-4) ');
        String? str = stdin.readLineSync()!;
        var spl = str.split(" ");
        print('List of your Branch Electives :');
        for (int i = 0; i < branch.length; i++) {
          if ((branch.elementAt(i).branch.compareTo(spl.elementAt(0)) == 0) &&
              (branch.elementAt(i).year == int.parse(spl.elementAt(1))))
            print('${branch.elementAt(i).toString()}');
        }
        print('List of Open Electives:');
        for (int j = 0; j < open.length; j++) {
          OpenElective op = open.elementAt(j);
          print('${op.toString()}');
        }
        break;
      default:
        print('Thanks for visiting :)');
        print('EXITING');
    }
  } while ((choice1 == 1) || (choice1 == 2));
}
