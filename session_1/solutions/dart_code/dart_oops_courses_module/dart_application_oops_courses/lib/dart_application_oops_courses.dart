import 'dart:core';

class Elective {
  String courseName;
  String courseCode;

  Elective(this.courseName, this.courseCode);
}

class OpenElective extends Elective {
  OpenElective(String cName, String cCode):super(cName, cCode);
}

class BranchElective extends Elective {
  String branchName;
  int year;

  BranchElective(String cName, String cCode, this.branchName, this.year):super(cName, cCode);
}

List<OpenElective> openElectiveList = [];
List<BranchElective> branchElectiveList = [];
