import 'dart:io';

class OpenElective {
  late String courseName;
  late String courseCode;

  void get() {
    print("$courseName\t$courseCode");
  }
}

class BranchElective {
  late String? courseName;
  late String? courseCode;
  late String? year;
  late String? branch;
  void get() {
    print("$courseName\t$courseCode");
  }

  String? yr() {
    return year;
  }

  String? brnh() {
    return branch;
  }
}

void main() {
  List<OpenElective> oel = [];
  List<BranchElective> bel = [];
  while (true) {
    print("Enter type of user 1.Admin 2.Student 3.Exit");
    int? user = int.parse(stdin.readLineSync()!);
    if (user == 1) {
      print("Enter course type 1.Open Elective 2.Branch Elective");
      int? crse = int.parse(stdin.readLineSync()!);
      if (crse == 1) {
        var cr = OpenElective();
        print("Enter Course Name:");
        cr.courseName = stdin.readLineSync()!;
        print("Enter Course Code:");
        cr.courseCode = stdin.readLineSync()!;
        oel.add(cr);
      } else if (crse == 2) {
        var cr = BranchElective();
        print("Enter Branch:");
        cr.branch = stdin.readLineSync()!;
        print("Enter Year:");
        cr.year = stdin.readLineSync()!;
        print("Enter Course Name:");
        cr.courseName = stdin.readLineSync()!;
        print("Enter Course Code:");
        cr.courseCode = stdin.readLineSync()!;
        bel.add(cr);
      }
    } else if (user == 2) {
      print("Enter Branch:");
      var br = stdin.readLineSync()!;
      print("Enter Year:");
      var yr = stdin.readLineSync()!;
      print("Open Electives:");
      for (int i = 0; i < oel.length; i++) {
        oel[i].get();
      }
      print("Branch Electives:");
      for (int i = 0; i < bel.length; i++) {
        if (bel[i].branch == br && bel[i].year == yr) {
          bel[i].get();
        }
      }
    } else {
      break;
    }
  }
}
