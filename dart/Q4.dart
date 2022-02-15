import 'dart:io';

void main() {
  var student1 = OpenElective();
  print("Enter branch");
  String? branch = stdin.readLineSync();
  print("Enter year");
  int? year = int.parse(stdin.readLineSync()!);
  var student = BranchElective(branch, year);
  for (int j = 0; j < 3; j++) {
    print("Enter type of user 1.Admin 2.Student");
    int? n = int.parse(stdin.readLineSync()!);
    if (n == 1) {
      print("Enter course type 1.Open elective 2.Branch elective");
      int? x = int.parse(stdin.readLineSync()!);
      if (x == 1) {
        print("Enter no. of open electives to added");
        int? g = int.parse(stdin.readLineSync()!);
        for (int h = 0; h < g; h++) {
          print("Enter course name");
          String? coursename = stdin.readLineSync();
          print("Enter course code");
          String? coursecode = stdin.readLineSync();
          student1.addcourse(coursename, coursecode);
        }
      } else {
        print("Enter no. of branch electives to added");
        int? g = int.parse(stdin.readLineSync()!);
        for (int h = 0; h < g; h++) {
          print("Enter course name");
          String? coursename = stdin.readLineSync();
          print("Enter course code");
          String? coursecode = stdin.readLineSync();

          student.addcourse(coursename, coursecode);
        }
      }
    } else {
      print("Enter branch");
      String? branch = stdin.readLineSync();
      print("Enter year");
      int? year = int.parse(stdin.readLineSync()!);
      student1.viewcourse();
      student.viewcourse(branch, year);
    }
  }
}

class BranchElective {
  List<String?> courseName = [];
  List<String?> courseCode = [];
  String? branch = "";
  int year = 0;
  BranchElective(this.branch, this.year);

  void addcourse(String? x, String? y) {
    courseName.add(x);
    courseCode.add(y);
  }

  void viewcourse(branch, year) {
    print(courseName);
  }
}

class OpenElective {
  List<String?> courseName = [];
  List<String?> courseCode = [];

  void addcourse(String? x, String? y) {
    courseName.add(x);
    courseCode.add(y);
  }

  void viewcourse() {
    print(courseName);
  }
}
