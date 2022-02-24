import 'dart:io';

void main() {
  print('Enter n');
  int? n = int.parse(stdin.readLineSync()!);
  print("First $n Fibinocci numbers are :");
  fibo(n);
}

void fibo(int n) {
  if (n <= 0) {
    print('You have entered a non-positive number');
    return;
  }
  if (n >= 1) print('0');
  if (n >= 2) print('1');
  int a = 0, b = 1, f;
  for (int i = 2; i < n; i++) {
    f = a + b;
    print('$f');
    a = b;
    b = f;
  }
}
