import 'dart:io';

class courses {
  var courseName, courseCode;

  courses(String courseName, String courseCode) {
    this.courseName = courseName;
    this.courseCode = courseCode;
  }

  String getCourseName() => this.courseName;
  void setCourseName(String courseName) => this.courseName = courseName;
  String getCourseCode() => this.courseCode;
  void setCourseCode(String courseCode) => this.courseCode;
  String toString() {
    return this.courseName + " " + this.courseCode;
  }
}

class BranchElective extends courses {
  var branchName, year;

  BranchElective(
      String courseName, String courseCode, String branchName, int year)
      : super(courseName, courseCode) {
    this.year = year;
    this.branchName = branchName;
  }

  String getCourseName() => this.courseName;
  String getCourseCode() => this.courseCode;
  void setCourseCode(String courseCode) => this.courseCode = courseCode;
  int getYear() => this.year;
  void setYear(int year) => this.year = year;
  void setCourse(String courseName) => this.courseName = courseName;
  String toString() {
    return this.courseName + " " + this.courseCode;
  }
}

class OpenElective extends courses {
  OpenElective(String courseName, String courseCode)
      : super(courseName, courseCode);

  String getCourseName() => this.courseName;
  String getCourseCode() => this.courseCode;

  String toString() {
    return this.courseName + " " + this.courseCode;
  }
}

int input() {
  return int.parse(stdin.readLineSync()!);
}

String inputString() => stdin.readLineSync().toString();
void main() {
  var opE = [];
  var brE = [];

  while (true) {
    print("enter user type : 1. admin  2. stduent");
    if (input() == 1) {
      print('admin');
      print('Enter course type  1.Open Elective  2.branch Elective');

      if (input() == 1) {
        print('enter course name');
        String c = inputString();
        print('Enter course code');
        String code = inputString();

        opE.add(new OpenElective(c, code));
      } else {
        print('Enter branch name');
        String branch = inputString();
        print('Enter year');
        int year = input();
        print('enter course name');
        String c = inputString();
        print('Enter course code');
        String code = inputString();

        opE.add(new BranchElective(c, code, branch, year));
      }
    } else {
      print('stduent');
      print('enter branch');
      String branch = inputString();
      print('enter year');
      int year = input();

      print('OpenElectives');
      opE.forEach((e) => print(e));

      print('\nBranchElectives');
      brE.forEach((e) {
        if (branch == e.getCourseName && year == e.getYear) print(e);
      });
    }
  }
}
