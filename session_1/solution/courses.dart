// Importing dart:io and our electives classes from electives.dart
import 'dart:io';
import 'coursesModule/electives.dart';

// Main Function
void main(){

  bool running = true;                                            //Condition for loop to run

  while(running){

    print("\nEnter type of user  1.Admin  2.Student  3.Exit");    //User input for user type
    String choice = stdin.readLineSync()!;


    if(choice == "2"){
      print("\nEnter Branch and year (eg. cs 2):");
      List details = stdin.readLineSync()!.split(" ");                // If student, user can type branch and year 
                                                                      //to get its branch and open electives

      print("Your Branch Electives: ${BranchElectives.getList(details)}");      // Calling static getList functions of branch
      print("Open Electives: ${OpenElectives.getList()}");                      // and open electives

    }


    else if(choice == "1"){
      bool adminLoopRunning = true;
      while(adminLoopRunning){                                                            // Running an admin loop

        print("\nEnter type of Elective  1.Branch Elective  2.Open Elective  3.Exit");          // Enter choice for elective type
        String electiveChoice = stdin.readLineSync()!;

        if(electiveChoice == "1"){
          print("\nEnter Operation Choice  1.View Courses  2.Add Course");              // Enter choice for operation to perform on
          String operationChoice = stdin.readLineSync()!;                               // branch elective

          if(operationChoice == "1") print("Branch Electives: ${BranchElectives.getFullList()}");  // Calling function to print all branch electives
          
          else if(operationChoice == "2") {
            print("\nEnter new Course details (eg. courseName courseCode branch year):");    // To add a new course
            String courseDetails = stdin.readLineSync()!;
            BranchElectives.addCourse(courseDetails);
          }
        }

        else if(electiveChoice == "2"){
          print("\nEnter Operation Choice  1.View Courses  2.Add Course");              // Enter choice for operation to perform on
          String operationChoice = stdin.readLineSync()!;                               // open elective

          if(operationChoice == "1") print("Open Electives: ${OpenElectives.getList()}"); // print all open electives
          
          else if(operationChoice == "2") {
            print("\nEnter new Course details (eg. courseName courseCode):");
            String courseDetails = stdin.readLineSync()!;                             // To add a new course
            OpenElectives.addCourse(courseDetails);
          }
        }

        else if(electiveChoice == "3") adminLoopRunning = false;                  // end admin loop
        else print("\nInvalid Choice\n");                                         // input error handling
      }
    }

    else if(choice == "3") running = false;                                       // ending program loop
    else print("\nInvalid Choice\n");                                           // input error handling
  }

}