import 'dart:io';

class BranchElective {
  late String courseName;
  late String courseCode;
  late String branch;
  late int year;

  BranchElective(String n, String c, String b, int y) {
    courseName = n;
    courseCode = c;
    branch = b;
    year = y;
  }

  void get() {
    print("$branch\t$year\t$courseName\t$courseCode");
  }
}

class OpenElective {
  late String courseName;
  late String courseCode;

  OpenElective(String n, String c) {
    courseName = n;
    courseCode = c;
  }

  void get() {
    print("$courseName\t$courseCode");
  }
}

void main() {
  List<BranchElective> branchElectives = <BranchElective>[];
  List<OpenElective> openElectives = <OpenElective>[];
  bool flag = true;
  var input;

  do {
    print("\nEnter type of user 1.Admin 2.Student");
    input = stdin.readLineSync();
    var t;
    if (input != null) t = int.parse(input);

    if (t == 1) {
      print("\nEnter course type 1.Open elective 2.Branch elective");
      input = stdin.readLineSync();
      var c;
      if (input != null) c = int.parse(input);

      if (c == 1) {
        String name = "", code = "";

        print("\nEnter course name and code");
        input = stdin.readLineSync();
        if (input != null) name = input;
        input = stdin.readLineSync();
        if (input != null) code = input;

        OpenElective o = OpenElective(name, code);
        openElectives.add(o);
      } else if (c == 2) {
        String name = "", code = "", branch = "";
        int year = 0;

        print("\nEnter course name, course code, branch and year");
        input = stdin.readLineSync();
        if (input != null) name = input;
        input = stdin.readLineSync();
        if (input != null) code = input;
        input = stdin.readLineSync();
        if (input != null) branch = input;
        input = stdin.readLineSync();
        if (input != null) year = int.parse(input);

        BranchElective b = BranchElective(name, code, branch, year);
        branchElectives.add(b);
      } else {
        print("\nInvalid Choice!!");
      }
    } else if (t == 2) {
      String branch = "";
      int year = 0;

      print("\nEnter branch and year");
      input = stdin.readLineSync();
      if (input != null) branch = input;
      input = stdin.readLineSync();
      if (input != null) year = int.parse(input);

      print("\nOpen Electives (CourseName => CourseCode):\n");

      for (var i = 0; i < openElectives.length; i++) openElectives[i].get();
      
      print("\nBranch Electives (Branch => Year => CourseName =? CourseCode):\n");

      for (var i = 0; i < branchElectives.length; i++)
        if (branchElectives[i].branch == branch &&
            branchElectives[i].year == year) branchElectives[i].get();
      
    } else {
      print("\nInvalid choice!!");
    }

    print("\n1.Continue 2.Exit");
    input = stdin.readLineSync();
    var k;
    if (input != null) k = int.parse(input);

    if (k == 2) flag = false;
  } while (flag);
}
