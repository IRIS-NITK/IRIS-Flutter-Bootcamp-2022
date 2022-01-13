import 'dart:math';
import 'dart:io';

bool primarr(int n, List<int> l) {
  int s = 0;
  int y;
  for (y in l) {
    s += y;
  }
  for (int i = 2; i < sqrt(s).floor() + 1; i++) {
    if (s % i == 0) {
      return false;
    }
  }
  return true;
}

void main() {
  print("Enter no. of terms of the array ");
  int? n = int.parse(stdin.readLineSync()!);
  List<int> l = [];
  for (int i = 0; i < n; i++) {
    print("Enter a prime no. ");
    int? x = int.parse(stdin.readLineSync()!);
    l.add(x);
  }
  if (primarr(n, l) == true) {
    print("True,the sum of the given array is prime");
  } else {
    print("False,the sum of the given array is not prime");
  }
}
