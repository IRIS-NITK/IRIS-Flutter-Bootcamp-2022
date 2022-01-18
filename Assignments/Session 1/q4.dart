import 'dart:io';

class OpenElective {
  String courseName;
  String courseCode;

  OpenElective(this.courseName,this.courseCode);
}

class BranchElective extends OpenElective{
  int year;
  String branch;

  BranchElective(this.branch, this.year, courseName, courseCode) : super(courseName, courseCode);
}


void main() {

  List<OpenElective> oel = [];
  List<BranchElective> bel = [];

  while (true) {
    print('Are you a 1.Admin 2.Student 3.Exit');
    int opt=int.parse(stdin.readLineSync().toString());

    switch (opt) {
      case 1:{
        print('Which course do you want to add 1.Open Elective 2. Branch Elective');
        int opt1=int.parse(stdin.readLineSync().toString());

        switch (opt1) {
          case 1:{
            print("Enter the course name and course code:");
                String n = stdin.readLineSync().toString();
                String c = stdin.readLineSync().toString();
                oel.add(OpenElective(n,c));
                print('Added successfully');
                break;
          }
          case 2:{
            print("Enter the branch, year, course name and course code");
                String bn = stdin.readLineSync().toString();
                int y = int.parse(stdin.readLineSync().toString());
                String n = stdin.readLineSync().toString();
                String c = stdin.readLineSync().toString();
                bel.add(BranchElective(bn,y,n,c));
                print('Added successfully');
                break;
          }
        }
      } 
      break;

      case 2:{
        print("Enter your branch and year");
        String bn = stdin.readLineSync().toString();
        int y= int.parse(stdin.readLineSync().toString());

        print("List of Open Electives:");
        oel.forEach((element) {print("${element.courseName} ${element.courseCode}");});
      
        print("List of Branch Electives:");
        bel.forEach((element) {
          if(element.branch == bn&& element.year == y){
            print("${element.courseName} ${element.courseCode}");
          }
        });
      }
      break;

      case 3:{
        exit(0);
      }
      }
    }
  }
