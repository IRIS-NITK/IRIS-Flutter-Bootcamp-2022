import 'dart:io';

//Creating respective classes
class OpenElective {
  String courseCode, courseName;
  OpenElective(this.courseCode, this.courseName);
}

class BranchElective extends OpenElective {
  String branch, year;

  BranchElective(this.branch, this.year, String courseCode, String courseName)
      : super(courseCode, courseName);
}

//Driver Code
int main() {
  List<OpenElective> open_electives = [
    OpenElective('OE500', 'AI')
  ]; //some default courses
  List<BranchElective> branch_electives = [
    BranchElective('CSE', '3RD', 'CS601', 'DBMS') //some default courses
  ];
  bool check = true;
  while (check) {
    stdout.write(
        "Enter type of user 1. Admin 2. Student ,Any other number to Exit : ");
    int? user = int.parse(stdin.readLineSync()!);
    switch (user) {
      case 1:
        stdout.write("Enter course type 1.Open elective 2.Branch elective : ");
        int? course = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Course name : ");
        String? course_name = stdin.readLineSync().toString().toUpperCase();
        stdout.write("Enter Course code : ");
        String? course_code = stdin.readLineSync().toString().toUpperCase();
        switch (course) {
          case 1:
            open_electives.add(OpenElective(course_code, course_name));
            break;
          case 2:
            stdout.write("Enter Branch and year separated by a space : ");
            String b_y = stdin.readLineSync().toString();
            List<String> ip = b_y.split(" ");
            String branch = ip[0].toUpperCase();
            String year = ip[1].toUpperCase();
            // stdout.write("Enter Year : ");
            // String? year = stdin.readLineSync();
            branch_electives
                .add(BranchElective(branch, year, course_code, course_name));
            break;
          default:
            print("Wrong input ");
        }
        break;
      case 2:
        stdout.write("Enter Branch and year separated by a space : ");
        String b_y = stdin.readLineSync().toString();
        List<String> ip = b_y.split(" ");
        String branch = ip[0].toUpperCase();
        String year = ip[1].toUpperCase();
        print("Branch Electives : ");
        for (BranchElective x in branch_electives) {
          if (x.branch == branch && x.year == year) {
            stdout.write(
                "${x.branch}    ${x.year}    ${x.courseCode}     ${x.courseName} \n");
          }
        }
        print("Open Electives : ");
        for (OpenElective x in open_electives) {
          stdout.write("${x.courseCode}     ${x.courseName}\n");
        }
        break;
      default:
        check = false;
        break;
    }
  }

  return 0;
}
