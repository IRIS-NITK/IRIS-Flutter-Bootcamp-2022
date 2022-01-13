import 'dart:io';
import 'dart:math';

bool isSemiPrime(int n) {
  int cnt = 0;
  for (int i = 2; cnt < 2 && i * i <= n; i++) {
    while (n % i == 0) {
      n ~/= i;
      cnt++;
    }
  }
  if (n > 1) ++cnt;
  return cnt == 2;
}

void main() {
  print("Enter the Number: ");
  int? n = int.parse(stdin.readLineSync()!);
  if (isSemiPrime(n))
    print("$n is a Semi Prime");
  else
    print("$n is not a Semi Prime");
}
