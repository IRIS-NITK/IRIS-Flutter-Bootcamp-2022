import 'dart:io';
void main() {
  List<String> BranchElectives = [];
    List<String> OpenElectives = [];
  while (true) {
    stdout.write("Enter Type of User: ");
    stdout.write("1.\x1B[33mAdmin\x1B[0m ");
    stdout.write("2.\x1B[33mStudent\x1B[0m \n");
    int? User = int.parse(stdin.readLineSync()!);
    if (User == 1) {
      stdout.write("Enter Type of Course: ");
      stdout.write("1. \x1B[33mBranch Electives\x1B[0m ");
      stdout.write("2. \x1B[33mOpen Elective\x1B[0m \n");
      int? Course = int.parse(stdin.readLineSync()!);
      stdout.write("Enter Course Name and Code: ");
      if (Course == 1) {
        BranchElectives.add(stdin.readLineSync()!);
      } else {
        OpenElectives.add(stdin.readLineSync()!);
      }
    } else {
      print("Enter Branch and Year: ");
      String? branch = stdin.readLineSync()!;
      if (branch != "") {
        print("Your Branch Electives are ");
        print(BranchElectives);
      }
      print("Your Open Electives are ");
      print(OpenElectives);
    }
    print("Exit the Loop?(y/n)");
    String? exit = stdin.readLineSync()!;
    if (exit == "y") break;
  }
}
