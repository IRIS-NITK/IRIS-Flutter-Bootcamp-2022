import 'dart:io';
import 'dart:core';

bool prime(int val) {
  if (val == 0 || val == 1) {
    return false;
  } else {
    for (int i = 2; i < val; i++) {
      if (val % i == 0) {
        return false;
      }
    }
  }
  return true;
}

bool semiprime(int num) {
  int n1 = 0, n2 = 0;
  for (int i = 2; i < num; i++) {
    if (num % i == 0) {
      n1 = i;
      n2 = (num ~/ n1);
      if (prime(n1) && prime(n2)) {
        return true;
      } else {
        return false;
      }
    }
  }
  return false;
}

void main() {
  print("Enter the number:");
  int? num = int.parse(stdin.readLineSync()!);
  if (semiprime(num)) {
    print("$num is semiprime");
  } else {
    print("$num is not a semiprime");
  }
}
