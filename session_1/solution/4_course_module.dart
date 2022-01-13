import 'dart:io';

class OpenElective {
  //variables
  var courseName = <String>[], courseCode = <String>[];
  //functions
  void addCourse() {
    print("Enter course name and code");
    String? temp = stdin.readLineSync();
    var lst = temp!.split(" ");
    courseName.add(lst[0]);
    courseCode.add(lst[1]);
  }

  void viewCourse() {
    for (int i = 0; i < courseCode.length; i++)
      print("Course Name: ${courseName[i]}  Course Code: ${courseCode[i]}");
  }
}

class BranchElective extends OpenElective {
  //variables
  var Branch, Year;
  //functions
  void addElective() {
    print("Enter branch and year");
    String? temp = stdin.readLineSync();
    var lst = temp!.split(" ");
    Branch = lst[0];
    Year = lst[1];
    addCourse();
  }

  void viewElective(String branch, String year) {
    for (int i = 0; i < courseCode.length; i++) {
      if (Branch == branch && Year == year)
        print("Course Name: ${courseName[i]}  Course Code: ${courseCode[i]}");
    }
  }
}

void main() {
  var oe = new OpenElective();
  var be = new BranchElective();
  print("Press Control-C to exit.");
  while (true) {
    print("Enter type of user 1.Admin 2.Student");
    int choice1 = int.parse(stdin.readLineSync()!);
    if (choice1 == 1) {
      print("Enter course type 1.Open elective 2.Branch elective");
      int choice2 = int.parse(stdin.readLineSync()!);
      if (choice2 == 1)
        oe.addCourse();
      else if (choice2 == 2) be.addElective();
    } else if (choice1 == 2) {
      print("Enter branch and year");
      String? temp = stdin.readLineSync();
      var lst = temp!.split(" ");
      String branch = lst[0];
      String year = lst[1];
      oe.viewCourse();
      be.viewElective(branch, year);
    }
  }
}
