import "courses.dart" show BranchElective, OpenElective;
import "dart:io";

List<BranchElective>list_be = [];
List<OpenElective>list_oe = [];

void admin(){
    print("Enter course type 1. Open Elective 2. Branch Elective");
    int choice = int.parse(stdin.readLineSync()!);
    if(choice == 1){
        var oe = new OpenElective();
        print("Enter course name.");
        oe.courseName = stdin.readLineSync()!;
        print("Enter course code.");
        oe.courseCode = stdin.readLineSync()!;
        list_oe.add(oe);
    }
    else if(choice == 2){
        var be = new BranchElective();
        print("Enter course name.");
        be.courseName = stdin.readLineSync()!;
        print("Enter course code.");
        be.courseCode = stdin.readLineSync()!;
        print("Enter branch.");
        be.branch = stdin.readLineSync()!;
        print("Enter year.");
        be.year = int.parse(stdin.readLineSync()!);
        list_be.add(be);
    }
    else{
        print("Wrong input");
    }
}

void student(){
    print("Enter the branch.");
    String branch = stdin.readLineSync()!;
    print("Enter the year.");
    int year = int.parse(stdin.readLineSync()!);
    print("The branch electives are:");
    for(int i = 0; i<list_be.length; i++){
        if(list_be[i].branch == branch && list_be[i].year == year){
            print("Course name : ${list_be[i].courseName}");
            print("Course code : ${list_be[i].courseCode}");
        }
    }
    print("The open electives are:");
    for(int i = 0; i<list_oe.length; i++){
        print("Course name : ${list_oe[i].courseName}");
        print("Course code : ${list_oe[i].courseCode}");
    }
}

void main(){
    print("Enter user type 1. Admin 2. Student");
    print("Enter -1 to stop the program.");
    int choice = int.parse(stdin.readLineSync()!);
    while (choice != -1){
        if(choice == 1){
            admin();
        }
        else if(choice == 2){
            student();
        }
        print("Enter user type 1. Admin 2. Student");
        choice = int.parse(stdin.readLineSync()!);
    }
    
    
}