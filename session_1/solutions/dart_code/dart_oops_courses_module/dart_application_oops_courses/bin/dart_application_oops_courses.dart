// ignore_for_file: avoid_relative_lib_imports
import '../lib/dart_application_oops_courses.dart';
import 'dart:io';
import "dart:core";

//For student -- input format is <branch> <year>
//For admin
//For Open Elective -- input format is <course-name> <course-code>
//For Branch -- input format is <course-name> <course-code> <branch> <year>

void main() {
  while (true) {
    stdout.write("Enter type of user 1.Admin 2.Student\n");
    var typeInput = stdin.readLineSync();

    if (typeInput != null) {
      int typeInputInt = int.parse(typeInput);

      if (typeInputInt == 1) {
        stdout.write("Enter course type 1.Open Elective 2.Branch Elective\n");
        var courseTypeInput = stdin.readLineSync();

        if (courseTypeInput != null) {
          int courseTypeInputInt = int.parse(courseTypeInput);

          if (courseTypeInputInt == 1) {
            var inputString = stdin.readLineSync();

            if (inputString != null) {
              var tokens = inputString.split(" ");
              openElectiveList.add(OpenElective(tokens[0], tokens[1]));
              stdout.write("Open Elective has been added successfully.\n");
            }
          } else if (courseTypeInputInt == 2) {
            var inputString = stdin.readLineSync();

            if (inputString != null) {
              var tokens = inputString.split(" ");
              branchElectiveList.add(BranchElective(
                  tokens[0], tokens[1], tokens[2], int.parse(tokens[3])));
              stdout.write("Branch Elective has been added successfully.\n");
            }
          }
        }
      } else if (typeInputInt == 2) {
        var inputString = stdin.readLineSync();

        if (inputString != null) {
          var tokens = inputString.split(" ");

          stdout.write("Open Electives are :\n");
          for (var course in openElectiveList) {
            stdout.write("${course.courseName} ${course.courseCode}\n");
          }

          stdout.write("Branch Electives are :\n");
          for (var course in branchElectiveList) {
            if (course.branchName == tokens[0] && course.year == int.parse(tokens[1])) {
              stdout.write("${course.courseName} ${course.courseCode}\n");
            }
          }
        }
      }
    }
  }
}
