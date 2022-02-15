//Checking if the given number is a Semiprime or not

import 'dart:io';

bool prime(int n) {
  if (n == 1) return false;
  for (int i = 2; i < n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

bool sempr(int n) {
  if (prime(n)) return false;
  for (int i = 2; i < n; i++) {
    if (n % i == 0) {
      if (!(prime(i)))
        return false;
      else if (!(prime((n / i).floor()))) return false;
    }
  }
  return true;
}

void main() {
  print('Please enter a value for n: ');
  int? n = int.parse(stdin.readLineSync()!);
  if (sempr(n))
    print('${n} is a SemiPrime Number');
  else
    print('${n} is not a SemiPrime Number');
}