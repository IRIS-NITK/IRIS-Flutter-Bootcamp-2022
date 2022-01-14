import 'package:dart_demo/dart_demo.dart' as dart_demo;
import 'dart:io';
import 'dart:convert';
import 'dart:core';

void main(List<String> arguments) {
  //Question 1
  print("How many fibonacci numbers do you want: ");
  int? n = int.parse(stdin.readLineSync()!);
  dart_demo.fibonacci(n);

  //Question 2
  print("\nEnter the numbers to check if its semiprime: ");
  double? m = double.parse(stdin.readLineSync()!);
  dart_demo.checkSemiprime(m);

  //Question 3
  List<double> arr = [2, 3, 4, 5];
  dart_demo.primearr(arr);
}
