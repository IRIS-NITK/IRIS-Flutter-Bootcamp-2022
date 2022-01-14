import 'courses.dart' show BranchElective, OpenElective;
import 'dart:io';

List<OpenElective> list_oe = [];
List<BranchElective> list_be = [];

void Admin() {
  print("\n---------------------------");
  print("[ USER : ADMIN ]\n");
  stdout.write(
      "Add which elective?\n1.Branch Electives\n2.Open Electives\nEnter choice : ");
  int? choice1 = int.parse(stdin.readLineSync()!);
  if (choice1 == 1) {
    var be = BranchElective();
    stdout.write("\nBranch-Elective courseName : ");
    be.courseName = stdin.readLineSync()!;
    stdout.write("Branch-Elective courseCode : ");
    be.courseCode = stdin.readLineSync()!;
    stdout.write("Branch-Elective branch     : ");
    be.branch = stdin.readLineSync()!;
    stdout.write("Branch-Elective year       : ");
    be.year = int.parse(stdin.readLineSync()!);
    list_be.add(be);
  } else if (choice1 == 2) {
    var oe = OpenElective();
    stdout.write("\nOpen-Elective courseName : ");
    oe.courseName = stdin.readLineSync()!;
    stdout.write("Open-Elective courseCode : ");
    oe.courseCode = stdin.readLineSync()!;
    list_oe.add(oe);
  } else {
    print("\nInvalid choice!");
  }
  print("---------------------------");
}

void Student() {
  print("\n---------------------------");
  print("\n[ USER : STUDENT ]\n");
  stdout.write(
      "view which elective?\n1.branch electives\n2.open electives\nEnter choice : ");
  int? choice2 = int.parse(stdin.readLineSync()!);
  if (choice2 == 1) {
    stdout.write("Year   : ");
    int? year = int.parse(stdin.readLineSync()!);
    stdout.write("Branch : ");
    String? branch = stdin.readLineSync();
    int i;
    print("\nBranch-Electives available : \n");
    for (i = 0; i < list_be.length; i++) {
      if ((branch == (list_be[i].branch)) && (year == (list_be[i].year))) {
        print("courseName : ${list_be[i].courseName}");
        print("courseCode : ${list_be[i].courseCode}\n");
      }
    }
  } else if (choice2 == 2) {
    int i;
    print("\nOpen-Electives available : \n");
    for (i = 0; i < list_oe.length; i++) {
      print("courseName : ${list_oe[i].courseName}");
      print("courseCode : ${list_oe[i].courseCode}\n");
    }
  } else {
    print("\nInvalid choice!\n");
  }
  print("---------------------------");
}

void main() {
  print("\nProgram to view/add courses in branch & open electives!\n");
  int exit = 0;
  while (true) {
    print("Users:\n1.Admin\n2.Student\n3*.Exit\n");
    stdout.write("Enter choice : ");
    int? choice = int.parse(stdin.readLineSync()!);
    (choice == 1) ? Admin() : ((choice == 2) ? Student() : exit = 1);
    if (exit == 1) {
      print("\nProgram terminated!\n");
      break;
    }
  }
}
