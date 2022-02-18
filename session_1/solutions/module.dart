import 'dart:io';

// dart run C:\Users\hp\OneDrive\Desktop\IRIS-Flutter-Bootcamp-2022\session_1\solution\module.dart
class branchElective {
  String? branch;
  String? year;

  List<String> coursename = [];
  List<String> coursecode = [];

  branchElective(
      String brnch, String yr, List<String> corsnames, List<String> corscodes) {
    branch = brnch;
    year = yr;
    coursename = corsnames;
    coursecode = corscodes;
  }
  void addcourse(String cname, String ccode) {
    coursename.add(cname);
    coursecode.add(ccode);
  }
}

class openelective {
  List<String> coursename = [];
  List<String> coursecode = [];
  openelective(List<String> cnames, List<String> ccodes) {
    coursename = cnames;
    coursecode = ccodes;
  }
  void addcourse(String cname, String ccode) {
    coursename.add(cname);
    coursecode.add(ccode);
  }

  void displaycourse() {
    print("list of open electives $coursename");
  }
}

void admin(List bele, ocourses) {
  print("enter course type 1.Open elective 2.branch elective");
  int? coursetype = int.parse(stdin.readLineSync()!);

  if (coursetype == 1) {
    print("course name and code");
    String? coursedata = stdin.readLineSync();
    ocourses.addcourse(coursedata!.split(" ")[0], coursedata.split(" ")[1]);
    print("course added");
  } else if (coursetype == 2) {
    print("enter the branch and year");
    String? branch_and_year = stdin.readLineSync();
    print("course name and code");
    String? coursedata = stdin.readLineSync();
    for (int i = 0; i < bele.length; i++) {
      if (bele[i].branch == branch_and_year!.split(" ")[0] &&
          bele[i].year == branch_and_year.split(" ")[1]) {
        bele[i].addcourse(coursedata!.split(" ")[0], coursedata.split(" ")[1]);
      }
    }
    print("course added");
  }
}

void student(List bele, openelective ocourses) {
  print("enter the branch and year");
  String? branch_and_year = stdin.readLineSync();

  for (int i = 0; i < bele.length; i++) {
    if (bele[i].branch == branch_and_year!.split(" ")[0] &&
        bele[i].year == branch_and_year.split(" ")[1]) {
      print("list of branch electives ${bele[i].coursename} ");
    }
  }

  ocourses.displaycourse();
}

void main() {
  branchElective cs1 =
      branchElective("cs", "1", ["dsd", "ai", "blockchain"], ["1", "2", "3"]);
  branchElective cs2 =
      branchElective("cs", "2", ["dsa", "ml", "big data"], ["4", "5", "6"]);
  branchElective cs3 = branchElective(
      "cs", "3", ["dsa2", "dl", "cloud computing"], ["7", "8", "9"]);
  branchElective cs4 = branchElective(
      "cs", "4", ["web dev", "cryptography", "robotics"], ["10", "11", "12"]);
  branchElective it1 = branchElective(
      "it", "1", ["dsd", "ai", "computer networks"], ["13", "14", "15"]);
  branchElective it2 =
      branchElective("it", "2", ["dsa", "ml", "automata"], ["16", "17", "18"]);
  branchElective it3 =
      branchElective("it", "3", ["dsa2", "dl", "os"], ["19", "20", "21"]);
  branchElective it4 = branchElective(
      "it", "4", ["app dev", "iot", "data mining"], ["22", "23", "24"]);

  List<String> opencnames = [
    "evs",
    "mech of materials",
    'calculus',
    "communication"
  ];
  List<String> openccodes = ["25", "26", "27", "28"];

  openelective ocourses = openelective(opencnames, openccodes);
  List bele = [cs1, cs2, cs3, cs4, it1, it2, it3, it4];

  print("enter the type of user 1.admin 2.student");
  int? type_of_user = int.parse(stdin.readLineSync()!);
  if (type_of_user == 1) {
    admin(bele, ocourses);
  } else if (type_of_user == 2) {
    student(bele, ocourses);
  }
}
