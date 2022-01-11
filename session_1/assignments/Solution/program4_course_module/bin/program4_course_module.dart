import 'dart:io';

List<String> BEcourseName = [];
List<String> BEcourseCode = [];
List<String> branch = [];
List<int> year = [];
List<String> OEcourseName = [];
List<String> OEcourseCode = [];

void admin() {
  var be = BranchElective();
  var oe = OpenElective();
  String code, name;
  while (true) {
    print("Enter the course type:\n1.Open Elective\n2.Branch Elective");
    print("Enter 0 to exit");
    int c = int.parse(stdin.readLineSync()!);
    if (c == 1) {
      print("Enter course code and name:");
      code = stdin.readLineSync() as String;
      name = stdin.readLineSync() as String;
      oe.createCourse(name, code);
    } else if (c == 2) {
      print("Enter course code, name, branch and year:");
      code = stdin.readLineSync() as String;
      name = stdin.readLineSync() as String;
      String br = stdin.readLineSync() as String;
      int yr = int.parse(stdin.readLineSync()!);
      be.createCourse(name, code, br, yr);
    } else if (c == 0) {
      break;
    } else {
      print("Invalid choice");
    }
  }
}

void student() {
  var be = BranchElective();
  var oe = OpenElective();
  print("Enter the branch and the year:");
  String br = stdin.readLineSync() as String;
  int yr = int.parse(stdin.readLineSync()!);
  print("Open electives:");
  print("Code\tName");
  oe.getCourse();
  print("Branch Electives:");
  print("Code\tName");
  be.getCourse(br, yr);
}

class BranchElective {
  void createCourse(String n, String c, String b, int y) {
    BEcourseName.add(n);
    BEcourseCode.add(c);
    branch.add(b);
    year.add(y);
  }

  void getCourse(String b, int y) {
    for (var i = 0; i < branch.length; i++) {
      if (b == branch[i] && y == year[i]) {
        stdout.write(BEcourseCode[i]);
        stdout.write("\t");
        stdout.write(BEcourseName[i]);
        stdout.write("\n");
      }
    }
  }
}

class OpenElective {
  void createCourse(String n, String c) {
    OEcourseName.add(n);
    OEcourseCode.add(c);
  }

  void getCourse() {
    for (var i = 0; i < OEcourseCode.length; i++) {
      stdout.write(OEcourseCode[i]);
      stdout.write("\t");
      stdout.write(OEcourseName[i]);
      stdout.write("\n");
    }
  }
}

void main(List<String> args) {
  while (true) {
    print("Enter the type of user:\n1.Admin\n2.Student");
    print("Enter 0 to exit");
    int ch = int.parse(stdin.readLineSync()!);
    if (ch == 1) {
      admin();
    } else if (ch == 2) {
      student();
    } else if (ch == 0) {
      break;
    } else {
      print("invalid option");
    }
  }
}
