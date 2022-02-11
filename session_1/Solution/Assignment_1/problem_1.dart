import 'dart:io';

void fibo(int n) {
  if (n < 1) return;
  int num1 = 0, num2 = 1;
  print(num1);
  for (int i = 0; i < n - 1; i++) {
    print(num2);
    int next = num1 + num2;
    num1 = num2;
    num2 = next;
  }
}

void main() {
  print("Enter the value of N:");
  int? n = int.parse(stdin.readLineSync()!);
  print("The First $n Fibonacci Numbers are:");
  fibo(n);
}
