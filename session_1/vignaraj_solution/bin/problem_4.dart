import 'dart:io';

// List of electives for all the branches(I found handling of external files quite complicated so resorted to this)
List cs = [
  ['cs_year1_elec1', 'cs_year1_elec2', 'cs_year1_elec3', 'cs_year1_elec4'],
  ['cs_year2_elec1', 'cs_year2_elec2', 'cs_year2_elec3', 'cs_year2_elec4'],
  ['cs_year3_elec1', 'cs_year3_elec2', 'cs_year3_elec3', 'cs_year3_elec4'],
  ['cs_year4_elec1', 'cs_year4_elec2', 'cs_year4_elec3', 'cs_year4_elec4']
];

List it = [
  ['it_year1_elec1', 'it_year1_elec2', 'it_year1_elec3', 'it_year1_elec4'],
  ['it_year2_elec1', 'it_year2_elec2', 'it_year2_elec3', 'it_year2_elec4'],
  ['it_year3_elec1', 'it_year3_elec2', 'it_year3_elec3', 'it_year3_elec4'],
  ['it_year4_elec1', 'it_year4_elec2', 'it_year4_elec3', 'it_year4_elec4']
];

List ai = [
  ['ai_year1_elec1', 'ai_year1_elec2', 'ai_year1_elec3', 'ai_year1_elec4'],
  ['ai_year2_elec1', 'ai_year2_elec2', 'ai_year2_elec3', 'ai_year2_elec4'],
  ['ai_year3_elec1', 'ai_year3_elec2', 'ai_year3_elec3', 'ai_year3_elec4'],
  ['ai_year4_elec1', 'ai_year4_elec2', 'ai_year4_elec3', 'ai_year4_elec4']
];

List openelectives = [
  'elec2',
  'elec3',
  'elec4',
  'elec5',
  'elec6',
  'elec7',
  'elec8'
];

String? branch;

int y = 0;
int ct = 0;
void main() {
  print("\nEnter type of user:  1.Admin  2.Student");

  int a;

  //Makes sure the user either inputs 1 or 2

  a = int.parse(stdin.readLineSync()!);

  int b;

  switch (a) {
    case 1:
      // Makes sure the user input either 1 or 2

      b = Options().printopt(a);

      print("Enter Course name and code");
      String input = (stdin.readLineSync()!);
      List courseandname = input.split(' ');
      switch (b) {
        case 1:
          openelectives.add(courseandname[0]);
          print("\nThe new list of open electives:\n$openelectives\n");
          break;
        case 2:
          switch (branch) {
            case "CS":
              cs[y - 1].add(courseandname[0]);
              print(
                  "\nThe new course list for Computer Science in the $y year :\n${cs[y - 1]}\n");
              break;
            case "AI":
              ai[y - 1].add(courseandname[0]);
              print(
                  "\nThe new course list for Artificial Intelligence in the $y year :\n${ai[y - 1]}\n");
              break;
            case "IT":
              it[y - 1].add(courseandname[0]);
              print(
                  "\nThe new course list for Information Technology in the $y year :\n${it[y - 1]}\n");
              break;
          }
          break;
      }
      break;
    case 2:
      b = Options().printopt(a);

      print("\nOpen Electives: $openelectives");
      switch (branch) {
        case "CS":
          print("\nBranch Electives:  ${cs[y - 1]}]\n");
          break;
        case "AI":
          print("\nBranch Electives:  ${ai[y - 1]}\n");
          break;
        case "IT":
          print("\nBranch Electives:  ${it[y - 1]}\n");
          break;
      }
      break;
  }
}

class Options {
  int printopt(int n) {
    if (n == 1) {
      print("Enter Course Type: 1.Open Elective  2.Branch Elective");
      ct = int.parse(stdin.readLineSync()!);
      if (ct == 2) {
        print("Enter branch (CS/IT/AI - allcaps):");
        branch = stdin.readLineSync()!;
        print("Enter year: ");
        y = int.parse(stdin.readLineSync()!);
      }
      return ct;
    } else if (n == 2) {
      print("Enter branch (CS/IT/AI - allcaps):");
      branch = stdin.readLineSync()!;
      print("Enter year: ");
      y = int.parse(stdin.readLineSync()!);
      return y;
    }
    return -1;
  }
}
