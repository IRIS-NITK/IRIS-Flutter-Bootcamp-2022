import 'dart:io';

void printFibonacci(int n) {
  List fibonacci = [0, 1];
  for (int i = 2; i < n; i++) {
    fibonacci.add(fibonacci[i - 1] + fibonacci[i - 2]);
  }

  stdout.write("\n");

  print("First $n Fibonacci Numbers are : ");

  for (var i=0;i<n;i++) {
    stdout.write(fibonacci[i]);
    stdout.write(' ');
  }
}

void main() {
  print(
      "******** Program to print the first N Fibonacci numbers(N is specified by the user) ********");

  stdout.write("Enter the value of N : ");
  try {
    int n = int.parse(stdin.readLineSync()!);
    if (n <= 0) {
      print("N must be greater than 0!!!");
      return;
    } else {
      printFibonacci(n);
    }
  } catch (e) {
    print("Please Enter Only Number!!!");
  }
}
