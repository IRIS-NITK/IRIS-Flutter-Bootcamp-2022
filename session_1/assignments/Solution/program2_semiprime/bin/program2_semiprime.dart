import 'dart:io';

bool is_Prime(int n) {
  if (n <= 1) {
    return false;
  } else {
    for (var i = 2; i < n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }
}

bool is_Semiprime(int a) {
  if (a <= 3) {
    return false;
  } else {
    for (int i = 2; i < a; i++) {
      if (a % i == 0) {
        double t = a / i;
        int f = t.floor();
        if (is_Prime(i) && is_Prime(f)) {
          return true;
        }
      }
    }
    return false;
  }
}

void main(List<String> args) {
  print("Enter a number:");
  int x = int.parse(stdin.readLineSync()!);
  if (is_Semiprime(x)) {
    print("The number is semiprime");
  } else {
    print("The number is not semiprime");
  }
}
