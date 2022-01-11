import 'dart:io';

bool checksemiprime(int n) {
  int cnt = 0;

  for (int i = 2; cnt < 2 && i * i <= n; ++i)
    while (n % i == 0) {
      n ~/= i;
      ++cnt;
    }

  if (n > 1) ++cnt;
  if (cnt == 2)
    return true;
  else
    return false;
}

void semiprime(int n) {
  if (checksemiprime(n)) {
    print("$n is a semi prime nber");
  } else {
    print("$n is not a semi prime nber");
  }
}

void main() {
  print("Enter a number : ");
  int? n = int.parse(stdin.readLineSync()!);
  semiprime(n);
}
