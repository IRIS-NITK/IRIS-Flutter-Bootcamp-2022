//Printing First N Fibonacci Numbers

import 'dart:io';

void fibo(int n) {
  int a = 0, b = 1;
  int c = a + b;
  print(a);
  print(b);
  print(c);

  for (int i = 4; i <= n; i++) {
    a = b;
    b = c;
    c = a + b;
    print(c);
  }
}

void main() {
  print('Please enter a value for n: ');
  int? n = int.parse(stdin.readLineSync()!);
  print('This is the corresponding Fibonacci Series:');
  fibo(n);
}
