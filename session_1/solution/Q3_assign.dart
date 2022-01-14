/*
*NOTICE:- ANY INPUT IS TAKEN AFTER A \n NEGLECTING \n  
*
*
*
*/
import 'dart:io';
import 'dart:math';

void main(List<String> args) {
  if(args.length==0){
  List<int> list= input();
  int sum=sumof(list);
  print(is_prime(sum));
  }
  else{
    int sum=0;
    for (var i = 0; i < args.length; i++) {
      
    int num = int.parse(args[i]);
    sum+=num;
    }
    print(is_prime(sum));
  
  }
}
int sumof(List<int> list){
  int sum=0;
  for (var i = 0; i < list.length; i++) {
    sum+=list[i];
  }
  return sum;
}

List<int> input(){
   stdout.write("input size of array :");
   stdin.lineMode=true;
   String? name=stdin.readLineSync();
   try {
    assert(name is String);
    int size = int.parse(name!);
    print("input size is $size");
    print("enter the array ");
    List<int> fi = [];
    for (var i = 0; i < size; i++) {
      stdout.write("element:");
      String? input=stdin.readLineSync();
      assert(input is String);
      int num=int.parse(input!);
      fi.add(num);
    }
    print(fi);
    return fi;
  } 
   catch (e) {
    print("👀 ❗❗oops something went wrong `❗❗ 👀");
    print(e);
    exit(-1);
  }
 
}
bool is_prime(var num) {
  if (num == 2 || num == 3) {
    return false;
  }
  if (num < 2 || num % 2 == 0) {
    return false;
  }
  if (num < 9) {
    return true;
  }
  if (num % 3 == 0) {
    return false;
  }
  var r = pow(num, 0.5);
  r = r.round();
  int f = 5;
  while (f <= r) {
    if (num % f == 0) {
      return false;
    }
    if (num % (f + 2) == 0) {
      return false;
    }
    f = f + 6;
  }
  return true;
}