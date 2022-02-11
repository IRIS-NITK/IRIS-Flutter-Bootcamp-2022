import 'dart:io';

class OpenElective {
  var CourseName = [], CourseCode = [];
  Add(String i, String j) {
    this.CourseName.add(i);
    this.CourseCode.add(j);
  }
}

class BranchElective {
  var CourseName = [], CourseCode = [], branch = [];
  List<int> year = [];
  Add(String i, String j, String b, int y) {
    this.CourseName.add(i);
    this.CourseCode.add(j);
    this.branch.add(b);
    this.year.add(y);
  }
}

void main() {
  var openElectives = new OpenElective(),
      branchElectives = new BranchElective();
  var w = 0;
  while (w != 2) {
    print("Enter the type of User: (1. Admin 2. Student)");
    int? t = int.parse(stdin.readLineSync()!);
    if (t == 1) {
      print("Enter Course Type: (1. Open Elective 2. Branch Elective)");
      int? c = int.parse(stdin.readLineSync()!);
      if (c == 1) {
        print("Enter Course Name and Code:(Each on a newline)");
        String bn = stdin.readLineSync()!;
        String bc = stdin.readLineSync()!;
        openElectives.Add(bn, bc);
      } else if (c == 2) {
        print("Enter Course Name, Code, Branch, Year:(Each on a new line)");
        String bn = stdin.readLineSync()!;
        String bc = stdin.readLineSync()!, b = stdin.readLineSync()!;
        int? y = int.parse(stdin.readLineSync()!);
        branchElectives.Add(bn, bc, b, y);
      } else
        print("Invalid Input!!");
    } else if (t == 2) {
      print("Enter Branch Name and Year(Each on a new line)");
      String B = stdin.readLineSync()!;
      int? Y = int.parse(stdin.readLineSync()!);
      if (openElectives.CourseName.isEmpty)
        print("There are no Open Electives added");
      else {
        print("The Open Electives are: ");
        print("Course Name : Course Code");
        for (int i = 0; i < openElectives.CourseCode.length; i++)
          print(
              "${openElectives.CourseName[i]} : ${openElectives.CourseCode[i]}");
      }
      print("");
      if (branchElectives.CourseName.isEmpty)
        print("There are no Branch Electives added");
      else {
        print("The Branch Electives are: ");
        print("Course Name : Course Code");
        for (int i = 0; i < branchElectives.CourseCode.length; i++)
          if (branchElectives.branch[i] == B && branchElectives.year[i] == Y)
            print(
                "${branchElectives.CourseName[i]} : ${branchElectives.CourseCode[i]}");
      }
    } else
      print("Invalid Input!!");
    print("");
    print("What to do now? (1. Continue\t 2.Exit)");
    w = int.parse(stdin.readLineSync()!);
    print("");
    if (w == 2)
      break;
    else
      continue;
  }
}
