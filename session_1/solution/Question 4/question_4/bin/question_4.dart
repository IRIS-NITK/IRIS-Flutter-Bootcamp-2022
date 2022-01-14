// import 'package:question_4/question_4.dart' as question_4;
// ignore_for_file: deprecated_member_use

import 'dart:io';


class BranchElective{

  String courseName='a';
  String courseCode='a';
  String branch='a';
  int year=0;

  // BranchElective(String name, String code, String branch, int year){
  //   courseCode = code;
  //   courseName = name;
  //   branch = branch;
  //   year = year;
  // }

}

class OpenElectives{

  String courseName='a';
  String courseCode='a';

}


void main() {

  var openarr = List<OpenElectives>.empty(growable: true);
  var brancharr = List<BranchElective>.empty(growable: true);

  while(true){

    int choice;
    print('Enter type of user 1. Admin 2. Student');

    choice = int.parse(stdin.readLineSync()!);

    if(choice==1){ //Admin

      print('Enter course type 1.Open elective 2.Branch elective');
      int? choice2 = int.parse(stdin.readLineSync()!);

      if(choice2==1){ // Open Elective

        print('Enter course name and code:');
        String name,code;
        name = stdin.readLineSync()!;
        code = stdin.readLineSync()!;

        var temp = OpenElectives();
        temp.courseCode = code;
        temp.courseName = name;

        openarr.add(temp);
      }

      else{
        if(choice2==2){ //Branch Elective

            String name,code,branch;
            int year;
            print('Enter course code name, course code, branch and year');
            name = stdin.readLineSync()!;
            code = stdin.readLineSync()!;
            branch = stdin.readLineSync()!;
            year = int.parse(stdin.readLineSync()!);

            var temp = BranchElective();
            temp.courseName = name;
            temp.branch = branch;
            temp.year = year;
            temp.courseCode = code;

        }
        else{
          return;
        }
      }

    }

    else{
      if(choice==2){ // Student

        String branch;
        int year;
        print('Enter branch and year');

        branch = stdin.readLineSync()!;
        year = int.parse(stdin.readLineSync()!);

        print('<List of open electives>');

        print('Course Name  Course Code');
        for(int i=0;i<openarr.length;i++){
          print(openarr[i].courseName);
          print(openarr[i].courseCode);
        }

        print('<List of branch electives>');

        for(int i=0;i<brancharr.length;i++){
          if(brancharr[i].branch == branch && brancharr[i].year == year){
            print(brancharr[i].courseName);
            print(brancharr[i].courseCode);
          }
        }

      }
      else{
        return;
      }
    }

  }


}
