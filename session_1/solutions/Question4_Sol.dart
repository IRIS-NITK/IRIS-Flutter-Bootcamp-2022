import 'dart:io';


class Open_Elective {
  List<String> OEC = []; //List of open elective course names, OEC - Open Elective Courses
  List<String> BEC = []; //List of branch elective course codes, BEC - Branch Elective Courses

  String? c_Name; // c_Name - Course Name
  String? c_Code; // c_Code - Course Code

  void takeInput() 
  {
    
    print("Enter course name : ");
    c_Name = stdin.readLineSync();
    OEC.add(c_Name!);
    print("Enter course code : ");
    c_Code = stdin.readLineSync();
    BEC.add(c_Code!);
  
  }

  void show() 
  {
    if (BEC.length == 0) 
    {
      print("No courses have been added");
    } 
    else 
    {
      print("Courses are:");
      for (int i = 0; i < BEC.length; i++) 
      {
        print("Course name: ${OEC[i]}  Course code:${BEC[i]}");
      }
    }
  }
}


class Branch_Elective {
  List<String> BCN = []; //List of branch elective course names, BCN - Branch Course Names
  List<String> BEC = []; // List of branch elective course codes, BEC - Branch Elective Courses
  List<String> br = []; //List containing branch name
  List<int> yr = []; //List containing year

  String? courseName;
  String? courseCode;
  String? branch;
  int? year;

  void takeInput() 
  {
    print("Enter name of branch:");
    branch = stdin.readLineSync();
    br.add(branch!);
    print("Enter year:");
    year = int.parse(stdin.readLineSync()!);
    yr.add(year!);
    print("Enter course name:");
    courseName = stdin.readLineSync();
    BCN.add(courseName!);
    print("Enter course code:");
    courseCode = stdin.readLineSync();
    BEC.add(courseCode!);
  }

  void show() 
  {
    bool found = false;
    print("Enter name of branch:");
    branch = stdin.readLineSync();
    print("Enter year:");
    year = int.parse(stdin.readLineSync()!);
    for (int i = 0; i < br.length; i++) 
    {
      if ((br[i] == branch) && (year == yr[i])) 
      {
        found = true;
        print("Course name: ${BCN[i]}  Course code:${BEC[i]}");
      }
    }
    if (found == false) 
    {
      print("No courses have been added");
    }
  }
}


void main() 
{
  var BE = new Branch_Elective();
  var OE = new Open_Elective();

  int? i = 1;

  while (i == 1) 
  {
    print("Enter type of user 1.Admin  2.Student");
    int? ch_1 = int.parse(stdin.readLineSync()!);
    print("Enter course type 1.Open elective  2.Branch elective");
    int? ch_2 = int.parse(stdin.readLineSync()!);
    if (ch_2 == 1) 
    {
      if (ch_1 == 1) 
      {
        OE.takeInput();
      }
      if (ch_1 == 2) 
      {
        OE.show();
      }
    }
    if (ch_2 == 2) 
    {
      if (ch_1 == 1) 
      {
        BE.takeInput();
      }
      if (ch_1 == 2) 
      {
        BE.show();
      }
    }
    print("Press 1 to continue and 0 to exit");
    i = int.parse(stdin.readLineSync()!);
  }
}
