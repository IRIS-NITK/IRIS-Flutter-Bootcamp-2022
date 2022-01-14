import 'dart:io';

void main() {
  BranchElective csBranch = BranchElective(); //initialising cs branch electives
  csBranch.branchElectives?.add("course1 CS110");
  csBranch.branchElectives?.add("course2 CS111");

  stdout.write("Enter type of user 1) Admin  2) Student\n");
  int userType = int.parse(stdin.readLineSync()!);

  if (userType != 1 && userType != 2) {
    stdout.write("Invalid user type");
    exit(-1);
  }

  if (userType == 1) {
    //admin access

    stdout.write("Enter course type 1) Open elective  2) Branch elective\n");
    int courseType = int.parse(stdin.readLineSync()!);

    if (courseType != 1 && courseType != 2) {
      stdout.write("Invalid course type");
      exit(-1);
    }

    stdout.write("Enter course name and code\n");
    List input = (stdin.readLineSync()!).split(
        ' '); //get the first two strings from input,exception not handled for 1 string
    String courseName = input[0];
    String courseCode = input[1];

    if (courseType == 1) {
      OpenElective.addToList(courseName, courseCode); //add to open elective
      OpenElective.printList(); //add to branch elective
    } else {
      csBranch.addToList(courseName, courseCode);
    }
  } else {
    //student access

    stdout.write("Enter branch and year\n");
    List input = (stdin.readLineSync()!).split(
        ' '); //get the first two strings from input,exception not handled for 1 string

    String branch = input[0];
    int year = int.parse(input[1]);

    if (branch == "cs") {
      //implemented only for cs
      csBranch.printElectives();
    } else {
      stdout.write("Invalid branch ( enter cs)");
    }
  }
}

class OpenElective {
  //open elective class, contains static members only

  static List? openElectives = ["elec1 EE102", "elec2 EEE102", "elec3 IT102"];

  static void printList() {
    stdout.write("Open Electives : $openElectives");
  }

  static void addToList(String newCourseName, String newCourseCode) {
    openElectives?.add(newCourseName + " " + newCourseCode);
  }

  List? get getOpenElectives => openElectives; //setter for static List

}

class BranchElective extends OpenElective {
  // branch electives, inheriting OpenElective class
  List? branchElectives = ["course0 CS100"];

  void printElectives() {
    stdout.write("Open Electives : ${super.getOpenElectives} \n");
    stdout.write("Branch Electives : $branchElectives \n");
  }

  void addToList(String newCourseName, String newCourseCode) {
    branchElectives?.add(newCourseName + " " + newCourseCode);
  }
}
