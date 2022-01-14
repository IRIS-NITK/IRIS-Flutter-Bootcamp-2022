import 'package:dart_demo/dart_demo.dart' as dart_demo;
import 'dart:io';
import 'dart:convert';
import 'dart:core';

// Question 1 : Print the first N Fibonacci numbers(N is specified by the user).

void fibonacci(int n) {
  stdout.write("0, 1, ");
  int n1 = 0;
  int n2 = 1;
  int n3 = 0;
  for (int i = 2; i < n; i++) {
    n3 = n1 + n2;
    stdout.write("$n3, ");
    n1 = n2;
    n2 = n3;
  }
  return;
}

// Question 2: Write a program to check whether the given number is semiprime or not

bool checkSemiprime(double num) {
  int cnt = 0;

  for (double i = 2; cnt < 2 && i * i <= num; ++i) {
    while (num % i == 0) {
      num /= i;

      ++cnt;
    }
  }
  if (num > 1) {
    ++cnt;
  }

  if (cnt == 2) {
    print("True");
    return true;
  } else {
    print("False");
    return false;
  }
}

// Question 3: Check whether the sum of prime elements of the array is prime or not

bool checkprime(double n) {
  for (int i = 2; i < n / 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

bool primearr(List arr) {
  double sum = 0;
  for (int i = 0; i < 4; i++) {
    if (checkprime(arr[i])) {
      sum += arr[i];
    }
  }

  if (checkprime(sum)) {
    print("True");
    return true;
  } else {
    print("False");
    return false;
  }
}

void main(List<String> arguments) {
  //Question 1
  print("How many fibonacci numbers do you want: ");
  int? n = int.parse(stdin.readLineSync()!);
  fibonacci(n);

  //Question 2
  print("\n\nEnter the numbers to check if its semiprime: ");
  double? m = double.parse(stdin.readLineSync()!);
  checkSemiprime(m);

  //Question 3
  print(
      "\n\nFor the list [2, 3, 4, 5] \nThe sum of prime elements of the array is prime: ");
  List<double> arr = [2, 3, 4, 5];
  primearr(arr);
}
