import 'dart:io';

void main(List<String> args) {
  print("Enter the number of terms:");
  int n = int.parse(stdin.readLineSync()!);
  int t1 = 0;
  int t2 = 1;
  print("$t1\n$t2");
  int t3;
  for (var i = 2; i < n; i++) {
    t3 = t1 + t2;
    print("$t3");
    t1 = t2;
    t2 = t3;
  }
}
