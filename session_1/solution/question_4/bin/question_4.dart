import 'dart:io';

class OpenElective {
  var courseName;
  var courseCode;
}

class BranchElective extends OpenElective {
  var branch;
  var year;
}

void main() {
  var admin = OpenElective();
  var admin_1 = BranchElective();
  admin.courseName = ['Management', 'Digital'];
  admin.courseCode = ['SM201', 'EC200'];
  admin_1.courseName = [
    'OOPS',
    'ML',
    'Welding',
    'WebDev',
    'Networking',
    'Computer Architecture'
  ];
  admin_1.courseCode = ['CS201', 'EC203', 'ME205', 'CS307', 'EC309', 'EC220'];
  int len = admin_1.courseCode.length;
  print("Current Open Electives Courses : ${admin.courseName}");
  print("Current Open Electives Course Code : ${admin.courseCode}");
  print("Current Branch Electives Courses : ${admin_1.courseName}");
  print("Current Branch Electives Course Code : ${admin_1.courseCode}");

  print("Enter type of user 1.Admin 2.Student");
  int? n = int.parse(stdin.readLineSync()!);
  if (n == 1) {
    print("Enter course type 1.Open elective 2.Branch elective");
    int? courseType = int.parse(stdin.readLineSync()!);
    if (courseType == 1) {
      print("Enter course name and code");
      String? name = stdin.readLineSync()!;
      admin.courseName.add(name);
      String? code = stdin.readLineSync()!;
      admin.courseCode.add(code);
      print(admin.courseName);
      print(admin.courseCode);
    } else if (courseType == 2) {
      print("Enter course name and code");
      String? name = stdin.readLineSync()!;
      admin_1.courseName.add(name);
      String? code = stdin.readLineSync()!;
      admin_1.courseName.add(code);
      print(admin_1.courseName);
      print(admin_1.courseCode);
    } else {
      print("Invalid");
    }
  } else if (n == 2) {
    var ans = [];
    print("Enter branch and year");

    admin_1.branch = stdin.readLineSync()!;
    admin_1.year = stdin.readLineSync()!;
    String code = admin_1.branch + admin_1.year;
    for (int i = 0; i < len; i++) {
      if (admin_1.courseCode[i].substring(0, 3) == code) {
        ans.add(admin_1.courseName[i]);
      }
    }
    print("Open Electives Courses : ${admin.courseName}"); //Open Elective
    print("Branch Electives Courses : $ans"); //Branch Elective
  } else {
    print("Invalid");
  }
}
