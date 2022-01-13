import 'dart:io';

void fibonacci(int n) {
  int a = 0, b = 1, c;
  print(a);
  print(b);
  for (int i = 0; i < n - 2; i++) {
    c = a + b;
    print(c);
    a = b;
    b = c;
  }
}

void main() {
  print("Enter a number n: ");
  int n = int.parse(stdin.readLineSync()!);
  fibonacci(n);
}
