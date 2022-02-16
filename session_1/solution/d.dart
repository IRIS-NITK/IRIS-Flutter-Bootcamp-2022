import 'dart:io';

class OpenElective {
  String courseName = "";
  String courseCode = "";

  OpenElective(String a, String b) {
    this.courseName = a;
    this.courseCode = b;
  }
}

class BranchElective extends OpenElective {
  String branch = "";
  String year = "";

  BranchElective(String a, String b, String c, String d) : super(a, b) {
    this.branch = c;
    this.year = d;
  }
}

void main(List<String> args) {
  List<OpenElective> lso = [];
  List<BranchElective> lsb = [];
  print("Please type 0 to continue--->");
  int n = int.parse(stdin.readLineSync()!);
  while (n == 0) {
    print("Enter type of user 1.Admin 2.Student");
    n = int.parse(stdin.readLineSync()!);
    var a;
    if (n == 1) {
      print("Enter course type 1.Open elective 2.Branch elective");
      n = int.parse(stdin.readLineSync()!);
      if (n == 1) {
        print("Enter course name and code");
        String x = stdin.readLineSync()!;
        String y = stdin.readLineSync()!;
        a = OpenElective(x, y);
        lso.add(a);
      } else {
        print("Enter course name ,code , branch, year ");
        String x = stdin.readLineSync()!;
        String y = stdin.readLineSync()!;
        String p = stdin.readLineSync()!;
        String q = stdin.readLineSync()!;
        a = BranchElective(x, y, p, q);
        lsb.add(a);
      }
    } else {
      print("Enter branch and year");
      String x = stdin.readLineSync()!;
      String y = stdin.readLineSync()!;
      print("Open electives :");
      for (OpenElective a in lso) {
        print("course : ${a.courseName}");
        print("code : ${a.courseCode}");
      }
      print("Branch electives :");
      for (BranchElective a in lsb) {
        if (a.branch == x && a.year == y) {
          print("course : ${a.courseName}");
          print("code : ${a.courseCode}");
        }
      }
    }
    n = int.parse(stdin.readLineSync()!);
  }
}
