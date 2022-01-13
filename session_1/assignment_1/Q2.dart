import 'dart:math';
import 'dart:io';

bool semiprime(var n) {
  if (n <= 1) {
    return false;
  }
  int k = 0;
  final x = sqrt(n).floor();
  for (int i = 2; i <= x; i++) {
    while (n % i == 0) {
      n /= i;
      k += 1;
    }
    if (k >= 2) {
      break;
    }
  }
  if (n > 1) {
    k += 1;
  }
  if (k == 2) {
    return true;
  } else {
    return false;
  }
}

void main() {
  print("Enter the no. to be checked ");
  int? n = int.parse(stdin.readLineSync()!);
  if (semiprime(n) == true) {
    print("True,the given number is semiprime");
  } else {
    print("False,the given number is not semiprime");
  }
}
