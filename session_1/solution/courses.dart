import 'dart:io';

class BranchElective {
  String courseName = '', courseCode = '';
  String Branch = '';
  int Year = 0;
  Map BranchElectiveCourses = Map();

  void set SetCourseName(String Cname) {
    this.courseName = Cname;
  }

  void set SetCourseCode(String Ccode) {
    this.courseCode = Ccode;
  }

  void AddToList() {
    if (this.BranchElectiveCourses["$Year $Branch"] == null) {
      this.BranchElectiveCourses["$Year $Branch"] = [
        [this.courseName, this.courseCode]
      ];
    } else {
      this
          .BranchElectiveCourses["$Year $Branch"]
          .add([this.courseName, this.courseCode]);
    }
  }

  void GetBranchElectives(String branch, int year) {
    if (this.BranchElectiveCourses.isEmpty) {
      stdout.write("\n");

      print(
          "There are no Branch Electives for Branch : $branch  and Year : $year!!!");
          stdout.write("\n");
      return;
    } else {
      if (BranchElectiveCourses["$year $branch"] == null) {
        stdout.write("\n");
        print(
            "There are no Branch Electives for Branch : $branch  and Year : $year!!!");
            stdout.write("\n");
        return;
      }

      List BranchElectivesList = this.BranchElectiveCourses["$year $branch"];

      if (BranchElectivesList.isEmpty) {
        stdout.write("\n");
        print(
            "There are no Branch Electives for Branch : $branch  and Year : $year!!!");
            stdout.write("\n");
        return;
      } else {
        stdout.write("\n");

        print(
            "List Of Branch Electives for Branch : $branch  and Year : $year are : ");
        stdout.write("\n");

        print("Sr.No\tCourse Name\tCourse Code");

        for (int i = 0; i < BranchElectivesList.length; i++) {
          print(
              "${i + 1}\t${BranchElectivesList[i][0]}\t\t${BranchElectivesList[i][1]}");
        }
      }
    }
  }

  void AddValues() {
    String branch;
    int year;

    print("Enter branch : ");
    branch = stdin.readLineSync()!;

    print("Enter year : ");
    year = int.parse(stdin.readLineSync()!);

    this.Branch = branch;
    this.Year = year;

    String CName, CCode;

    print("Enter course name : ");
    CName = stdin.readLineSync()!;

    print("Enter course code : ");
    CCode = stdin.readLineSync()!;

    this.SetCourseName = CName;
    this.SetCourseCode = CCode;

    this.AddToList();
  }
}

class OpenElective {
  String courseName = '', courseCode = '';
  List<List> OpenElectiveCourses = [];

  void set SetCourseName(String Cname) {
    this.courseName = Cname;
  }

  void set SetCourseCode(String Ccode) {
    this.courseCode = Ccode;
  }

  void AddToList() {
    this.OpenElectiveCourses.add([this.courseName, this.courseCode]);
  }

  void GetOpenElectives() {
    if (this.OpenElectiveCourses.isEmpty) {
      stdout.write("\n");
      print("There are no Open Electives!!!");
      return;
    } else {
      stdout.write("\n");
      print("List Of Open Electives : ");
      stdout.write("\n");
      print("Sr.No\tCourse Name\tCourse Code");
      for (int i = 0; i < this.OpenElectiveCourses.length; i++) {
        print(
            "${i + 1}\t${OpenElectiveCourses[i][0]}\t\t${OpenElectiveCourses[i][1]}");
      }
    }
  }

  void AddValues() {
    
    String CName, CCode;

    print("Enter course name : ");
    CName = stdin.readLineSync()!;

    print("Enter course code : ");
    CCode = stdin.readLineSync()!;

    this.SetCourseName = CName;
    this.SetCourseCode = CCode;
    this.AddToList();
  }
}

void main() {
  try {
    bool flag = false;
    BranchElective branchElective = BranchElective();
    OpenElective openelective = OpenElective();
    do {
      print("Enter type of user 1.Admin 2.Student");
      int UserType = int.parse(stdin.readLineSync()!);

      if (UserType == 1) {
        print("Enter course type 1.Open elective 2.Branch elective");
        int CourseType = int.parse(stdin.readLineSync()!);
        if (CourseType == 1) {
          openelective.AddValues();
        } else if (CourseType == 2) {
          branchElective.AddValues();
        } else {
          print("Invalid Input!!!");
          print("Please Select number 1 or 2.");
        }
      } else if (UserType == 2) {
        String branch;
        int year;

        print("Enter branch : ");
        branch = stdin.readLineSync()!;

        print("Enter year : ");
        year = int.parse(stdin.readLineSync()!);

        openelective.GetOpenElectives();
        branchElective.GetBranchElectives(branch, year);
      } else {
        print("Invalid Input!!!");
        print("Please Select number 1 or 2.");
      }

      stdout.write('Do you want to Add or View Courses Again?(Y/N) : ');

      String input = stdin.readLineSync()!;
      if (input == 'Y' || input == 'y' || input == 'Yes' || input == "yes") {
        flag = true;
      } else {
        flag = false;
      }
    } while (flag);
    print("Thank you!!");
  } catch (e) {
    print("Exception Occured!!!!");
    print("Exception : $e");
  }
}
