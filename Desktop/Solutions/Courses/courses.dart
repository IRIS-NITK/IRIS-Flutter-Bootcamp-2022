import 'dart:io';

//List of open electives. Took example courses.
var open_electives=["CS 104","IT 203","EC 219","MN 236"];

// Map which contains branch and year as key and list of branch electives as data.
Map branch_electives={"CS 2024":["CS 213","IT 215","CS 201","IT 211"],"IT 2024":["IT 215","IT 211","SD 315","CC 305"],"MN 2024":["MN 201","MN 210","CV 218","CV 203"]};


void student(){
  print("Enter branch and year");
  String? s=stdin.readLineSync();
  print("The list of open electives are:");
  print(open_electives);
  print("\n");
  print("The list of branch electives are:");
  if(branch_electives.containsKey(s)){
    print(branch_electives[s]);
  }
  else{
    print("There are no branch electives.");
  }
  print("\n");
  take_input();
}

void admin(){
  print("Enter course type 1.Open elective 2.Branch elective");
  int? n= int.parse(stdin.readLineSync()!);
  if(n==1){
    print("Enter the course name and course code");
    String? s=stdin.readLineSync()!;
    open_electives.add(s);
  }
  if(n==2){
    print("Enter the branch and year");
    String? s=stdin.readLineSync()!;
    print("Enter the course name and code");
    String? p=stdin.readLineSync()!;
    if(branch_electives.containsKey(s)){
      branch_electives[s].add(p);
    } 
    else{
      branch_electives[s]=[];
      branch_electives[s].add(p);
    }
  }
  print("\n");
  take_input();
}

void error(){
  print("Invalid entry\n\n");
  take_input();
}

void take_input(){
  print("Enter the type of user 1.Admin 2.Student");
  int? n =int.parse(stdin.readLineSync()!);
  
  if(n==1){
    admin();
  }
  else if(n==2){
    student();
  }
  else{
    error();
  }
}


void main(){
  take_input();
}