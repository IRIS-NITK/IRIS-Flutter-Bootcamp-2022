import 'dart:io';

void main(List<String> args) {
  print("Q4 ");
   String path=("/IRIS-Flutter-Bootcamp-2022/session_1/solution/text.txt");//path to text.txt
   File file = new File(path);
   List<String> data=file.readAsLinesSync();
  print("Enter type of user 1)ADMIN 2)Student ");
  String? input=stdin.readLineSync();
//if admin 
  if(input=='1'){
   //admin part
    print("HELLO ADMIN ");
    print("enter 1)Branch electives 2)open electives ");
    String? inpu=stdin.readLineSync();
    if(inpu=='1'){
      //if selected Branch electives 
      print("Enter branch");
      String? br=stdin.readLineSync();
      print("Enter year");
      String? yr=stdin.readLineSync();
      int year =int.parse(yr!);
      // eg  "chem-ch01" for adding chemisty course
      //errors include no input error 
      print("name of course and its code follow format");
      String? info=stdin.readLineSync();
      if (inpu!="") {
       assert(inpu is String);
        //not blank 
         add(data, br!, year, info!, file);
      }
    }
    else{
      //if selected open electives 
       print("name of course and its code follow format");
      String? info=stdin.readLineSync();
      add2(data, info!, file);
    }
  }
  //if student
  else{
    print("enter 1)Branch electives 2)open electives ");
    String? inpu=stdin.readLineSync();
    if (inpu=='1') {
     print("Enter branch");
      String? br=stdin.readLineSync();
      print("Enter year");
      String? yr=stdin.readLineSync();
      try {
        int year=int.parse(yr!);
        assert(br is String);
        phrase(data, br!, year);
      } catch (e) {
        print(e);
        exit(-1);
      }  
    }else{
      //open ective view mode
      List<String> l=data[data.length-1].split(":")[1].split("|"); 
       for (var i = 0; i < l.length; i++) {
         print(l[i]);
       }
    }    
  }
}
//for adding open elective 
void add2(List<String> data, String info, File file) {
  //last line 
  List<String> course=data[data.length-1].split(":");
  String s="opene";
  if (s==course[0]) {
    //data is ok 
    List<String> codes=course[1].split("|");
    for (var i = 0; i <codes.length; i++) {
      if (codes[i]==info) {
        print("course is already present ");
        exit(0);
      }
    }
    //no dupelication
    s=s+":"+course[1]+"|"+info;//apppeded info to data 
    data[data.length-1]=s;
    write_lines(data, file);
  }
  else{
    //open electives must always be at end of txt file 
    print("data error");
  }
}
//for reading all course 
void phrase(List<String> data, String c_name, int year) {
  //dont read last line 
  for (var i = 0; i < data.length-1; i++) {
    String temp = data[i].split(":")[0];
    if (temp == c_name) {
      //found match need to check year
      List<String> l = data[i].split(":")[1].split(",");
      for (var j = 0; j < l.length; j += 2) {
        int temp = int.parse(l[j]);
        if (temp == year) {
          //found all courses
          l = l[j + 1].split("|");
          for (var i = 0; i < l.length; i++) {
            print(l[i]);
          }
          exit(0);
        }
      }
    }
  }
  print("couldn't find what u r looking for ");
}
//adding course 
Future<void> add(
    List<String> data, String c_name, int year, String info, File file) async {
  for (var i = 0; i < data.length; i++) {
    //fech course name
    String c = data[i].split(":")[0];
    if (c == c_name) {
      //found match need to check year

      List<String> l = data[i].split(":")[1].split(",");
      //l contains years and courses
      for (var j = 0; j < l.length; j += 2) {
        //find year
        int temp = int.parse(l[j]);
        if (temp == year) {
          //found all courses

          List<String> disp = l[j + 1].split("|");
          print("\n");
          print("courses present in brach:${c_name} year:${year}");
          for (var k = 0; k < disp.length; k++) {
            print(disp[k]);
            if (info == disp[k]) {
              print("this course is already added ");
              exit(0);
            }
          }
          l[j + 1] += ("|" + info);
          String k = l.join(",");
          c = c + ":" + k;
          data[i] = c;
          write_lines(data, file);
          exit(0);
        }
      }
    }
  }
}
//writing to file 
Future<void> write_lines(List<String> data, File file) async {
  try {
    String wrt = data.join("\n");
    file.writeAsStringSync(wrt);
  } catch (e) {
   print("file i/o error ");
    print(e);
  }
}
