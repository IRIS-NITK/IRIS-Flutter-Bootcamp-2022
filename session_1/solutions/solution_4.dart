import 'dart:io';

class OpenElective {
  late String ? CourseCode;
  late String ? courseName;
  void display() {
    print('$CourseCode,$courseName');
  }
}

class BranchElective {
  late String ? CourseCode;
  late String ? courseName;
  late String ? branch;
  late int ? year;
  void display() {
    print('$CourseCode,$courseName');
  }

  String ? get branchname {
    return branch;
  }

  int ? get yearofstudy {
    return year;
  }
}

void main() {
  var OElectives = [];
  var BElectives = [];
  while (true) {
    print("Enter the type of user : 1. Admin  2.Student  3.Exit ");

    int ? user = int.parse(stdin.readLineSync()!);
    if (user == 1) {
      print("Enter Course type : 1.Branch Electives  2.Open Electives");
      var ch = int.parse(stdin.readLineSync()!);
      if (ch == 1) {
        var object = new BranchElective();
        print('Enter Course Code : ');
        object.CourseCode = stdin.readLineSync();
        print('Enter Course Name : ');
        object.courseName = stdin.readLineSync();
        print('Enter Branch : ');
        object.branch = stdin.readLineSync();
        print('Enter Year : ');
        object.year = int.parse(stdin.readLineSync()!);
        BElectives.add(object);
      } else if (ch == 2) {
        var object = new OpenElective();
        print('Enter Course Code : ');
        object.CourseCode = stdin.readLineSync();
        print('Enter Course Name : ');
        object.courseName = stdin.readLineSync();
        OElectives.add(object);
      }
    } else if (user == 2) {
      print('Enter Year of Study : ');
      var year = int.parse(stdin.readLineSync()!);
      print('Enter Branch name : ');
      var bname = stdin.readLineSync();
      print('Branch Electives : ');
      for (var i = 0; i < BElectives.length; i++) {
        if (BElectives[i].branchname == bname &&
            BElectives[i].yearofstudy == year) BElectives[i].display();
      }
      
      print('Open Electives : ');
      for (var i = 0; i < OElectives.length; i++) {
        OElectives[i].display();
      }
    } else {
      break;
    }
  }
}

