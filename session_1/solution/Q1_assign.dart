import 'dart:io';
void main() {
  print("Question 1 Fibunnachi series");
  print("input a number ");
  String? name = stdin.readLineSync();
  try {
    assert(name is String);
    int num = int.parse(name!);
    fib(num,",");
  } catch (e) {
    print("👀 ❗❗input is not integer❗❗ 👀");
    print(e);
    exit(-1);
  }
}
int fib(int num,String str) {
   int k=1;
   int j=0;
   int current=0;
   for (var i = 0; i < num; i++) {
     stdout.write(current,);
     stdout.write(str);
     j=k;
     k=current;
     current=k+j;
   }
   print("\n");
   return 0;
}
