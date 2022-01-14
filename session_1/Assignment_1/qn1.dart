import 'dart:io';

void fibonacci(int n) {
  int a = 1, b = 1, c;
  print("$a");
  print("$b");
  for (int i = 2; i < n; i++) {
    c = a + b;
    a = b;
    b = c;
    print("$c");
  }
}

void main() {
  print('Value of N:');
  int? n = int.parse(stdin.readLineSync()!);
  print("Fibonacci Series:");
  fibonacci(n);
}
