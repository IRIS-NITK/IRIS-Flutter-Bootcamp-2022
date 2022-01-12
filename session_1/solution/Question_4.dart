import 'dart:io';

class BranchElective {
  List<String> B_CN = []; //List containing branch elective course name
  List<String> B_CD = []; //List containing branch elective course code
  List<String> br = []; //List containing branch name
  List<int> yr = []; //List containing year

  String? courseName;
  String? courseCode;
  String? branch;
  int? year;

  void takeInput() {
    print("Enter name of branch:");
    branch = stdin.readLineSync();
    br.add(branch!);
    print("Enter year:");
    year = int.parse(stdin.readLineSync()!);
    yr.add(year!);
    print("Enter course name:");
    courseName = stdin.readLineSync();
    B_CN.add(courseName!);
    print("Enter course code:");
    courseCode = stdin.readLineSync();
    B_CD.add(courseCode!);
  }

  void display() {
    bool found = false;
    print("Enter name of branch:");
    branch = stdin.readLineSync();
    print("Enter year:");
    year = int.parse(stdin.readLineSync()!);
    for (int i = 0; i < br.length; i++) {
      if ((br[i] == branch) && (year == yr[i])) {
        found = true;
        print("Course name: ${B_CN[i]}  Course code:${B_CD[i]}");
      }
    }
    if (found == false) {
      print("No courses have been added");
    }
  }
}

class OpenElective {
  List<String> O_CN = []; //List containing open elective course name
  List<String> O_CD = []; //List containing branch elective course code

  String? courseName;
  String? courseCode;

  void takeInput() {
    print("Enter course name:");
    courseName = stdin.readLineSync();
    O_CN.add(courseName!);
    print("Enter course code:");
    courseCode = stdin.readLineSync();
    O_CD.add(courseCode!);
  }

  void display() {
    if (O_CD.length == 0) {
      print("No courses have been added");
    } else {
      print("Courses are:");
      for (int i = 0; i < O_CD.length; i++) {
        print("Course name: ${O_CN[i]}  Course code:${O_CD[i]}");
      }
    }
  }
}

void main() {
  var BE = new BranchElective();
  var OE = new OpenElective();

  int? i = 1;

  while (i == 1) {
    print("Enter type of user 1.Admin  2.Student");
    int? ch_1 = int.parse(stdin.readLineSync()!);
    print("Enter course type 1.Open elective  2.Branch elective");
    int? ch_2 = int.parse(stdin.readLineSync()!);
    if (ch_2 == 1) {
      if (ch_1 == 1) {
        OE.takeInput();
      }
      if (ch_1 == 2) {
        OE.display();
      }
    }
    if (ch_2 == 2) {
      if (ch_1 == 1) {
        BE.takeInput();
      }
      if (ch_1 == 2) {
        BE.display();
      }
    }
    print("Press 1 to continue and 0 to exit");
    i = int.parse(stdin.readLineSync()!);
  }
}
