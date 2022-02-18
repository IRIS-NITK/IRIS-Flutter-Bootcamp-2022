import 'dart:io';

bool isprime(num n) {
  if (n == 1) {
    return false;
  }
  for (int i = 2; i < n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}

bool issemiprime(num n) {
  num d1, d2;

  for (int i = 2; i < n; i++) {
    if (n % i == 0) {
      d1 = i;
      d2 = n / d1;
      if (isprime(d1) && isprime(d2)) {
        return true;
      } else {
        return false;
      }
    }
  }
  return false;
}

void main() {
  print("enter the no.");
  int? n = int.parse(stdin.readLineSync()!);
  if (issemiprime(n)) {
    print("This no. is semiprime ");
  } else {
    print("This no. is not semiprime ");
  }
}
