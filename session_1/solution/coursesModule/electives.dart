//Importing dart:io for file handling
import 'dart:io';

// Defining an abstract class electives to define basic functionalities of an elective class
abstract class Electives{
  abstract String courseName;
  abstract String courseCode;

}

// Defining our Branch Electives Class
class BranchElectives extends Electives{

  var courseName, courseCode, branch, year;

  BranchElectives(this.courseName, this.courseCode, this.branch, this.year);     // Constructor

  static List getList(List details){    // To get list of branch electives corresponding to given branch and year

    File file = File('./coursesModule/branchElectives.txt');      // Read our Branch electives list from branchElectives.txt
    List lines = file.readAsLinesSync();

    List line = [];
    lines.forEach((element) => line.add(element.split(",")));      // Converting to list

    List courses = [];
    line.forEach((element) {
      if(details[0] == element[2] && details[1] == element[3]){     //Conditions to check
        courses.add(element[0]);
      }
      });

    return courses; 
  }


    static List getFullList(){                 // To get list of all branch electives

    File file = File('./coursesModule/branchElectives.txt');        // Read our Branch electives list from branchElectives.txt
    List lines = file.readAsLinesSync();

    List line = [];
    lines.forEach((element) => line.add(element.split(",")));       // Converting to list

    List courses = [];
    line.forEach((element)=>courses.add(element[0]));               // Formatting for return

    return courses;
  }

  static void addCourse(String courseDetails){                  //  To add a course to branch elective list

    String insert = courseDetails.replaceAll(" ", ",");        // Formatting

    File file = File('./coursesModule/branchElectives.txt');
    file.writeAsStringSync("\n$insert",mode: FileMode.append);     // Append new course to branchElectives.txt
    print('\nCourse added.\n');
  }
}




class OpenElectives extends Electives{

  var courseName, courseCode;

  OpenElectives(this.courseName, this.courseCode);    // Constructor

  static List getList(){                                // To get list of Open electives

    File file = File('./coursesModule/openElectives.txt');
    List lines = file.readAsLinesSync();                              // Read our Open electives list from openElectives.txt

    List line = [];
    lines.forEach((element) => line.add(element.split(",")));         // Converting to list

    List courses = [];
    line.forEach((element)=>courses.add(element[0]));

    return courses;
  }

    static void addCourse(String courseDetails){                 // Add new course to list

    String insert = courseDetails.replaceAll(" ", ",");              // Formatting

    File file = File('./coursesModule/openElectives.txt');
    file.writeAsStringSync("\n$insert",mode: FileMode.append);      // Append new course to openElectives.txt
    print('\nCourse added.\n');
  }
}