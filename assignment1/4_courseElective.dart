import 'dart:io';

//class definitions
class Open_Elective {
  //string variables for coursename and coursecode
  var courseName = <String>[];
  var courseCode = <String>[];
  //functions
  void addCourse() {
    //input course name and code and add them to repective lists
    print("Enter course name and code");
    //input in a single line both name and code
    String? temp = stdin.readLineSync();
    //split the temp input by " " and assign it to a list
    var tempList = temp!.split(" ");
    //0th index of list represent course name and 1st index is the course code
    courseName.add(tempList[0]);
    courseCode.add(tempList[1]);
  }

  //function to print all the course name and code
  void viewCourse() {
    for (int i = 0; i < courseCode.length; i++)
      print("Course Name: ${courseName[i]}  Course Code: ${courseCode[i]}");
  }
}

//branch elective class definition inherited from open elective class
class Branch_Elective extends Open_Elective {
  //variables of this class
  var branch, year;
  //functions
  void addElective() {
    //input branch name and year
    print("Enter branch and year");
    String? temp = stdin.readLineSync();
    var tempList = temp!.split(" ");
    branch = tempList[0];
    year = tempList[1];
    //call the function to add elective coure for that brach and year
    addCourse();
  }

  //function to print the course name and code of that specific student whose branch and elective are given
  void viewElective(String br, String yr) {
    //repeat a loop
    for (int i = 0; i < courseCode.length; i++) {
      //if given branch and year matches with the one in the list then print its name and code
      if (branch == br && year == yr)
        print("Course Name: ${courseName[i]}  Course Code: ${courseCode[i]}");
    }
  }
}

void main() {
  //create class objects
  var openElectiveObject = new Open_Elective();
  var branchElectiveObject = new Branch_Elective();
  while (true) {
    print("\nEnter type of user 1.Admin 2.Student 3. Exit");
    //input user's choice
    int user_choice = int.parse(stdin.readLineSync()!);
    if (user_choice == 1) {
      print("Enter course type 1.Open elective 2.Branch elective");
      //input user's choice on elective
      int elective_choice = int.parse(stdin.readLineSync()!);
      //if choice is 1, call addCourse() function
      if (elective_choice == 1)
        openElectiveObject.addCourse();
      //else call function to addElective()
      else if (elective_choice == 2) branchElectiveObject.addElective();
    } else if (user_choice == 2) {
      print("Enter branch and year");
      //input user's branhc and year
      String? temp = stdin.readLineSync();
      var templist = temp!.split(" ");
      String branch = templist[0];
      String year = templist[1];
      //print all open electives
      print("\nOpen Electives are: ");
      openElectiveObject.viewCourse();
      //print all branch electives according to student's branch and year
      print("\nBranch Electives are: ");
      branchElectiveObject.viewElective(branch, year);
    } else {
      print("Thank you");
      break;
    }
  }
}
