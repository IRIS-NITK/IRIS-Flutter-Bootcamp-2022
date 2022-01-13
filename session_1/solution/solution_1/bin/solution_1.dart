// ignore_for_file: unused_import

import 'package:solution_1/solution_1.dart' as solution_1;
import 'dart:io';

main(List<String> arguments) {
  print('Enter the number: ');
  int? n = int.parse(stdin.readLineSync()!);
  print('The first $n Fibonacci numbers are:');
  fibonacci(n);
}

void fibonacci(int n) {
  int n1 = 0, n2 = 1, n3;
  print(n1);
  print(n2);
  for (int i = 2; i < n; i++) {
    n3 = n1 + n2;
    print(n3);
    n1 = n2;
    n2 = n3;
  }
}
