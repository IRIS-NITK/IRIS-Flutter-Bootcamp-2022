import 'dart:io';

bool check(int n) {
  int count = 0;

  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) count++;
  }

  return count == 1;
}

void main() {
  print('enter the number');
  int? a = int.parse(stdin.readLineSync()!);

  print((check(a) ? "yes $a is semiprime" : "no $a is not a semiprime"));
}
