// ignore_for_file: unused_import

import 'package:solution_2/solution_2.dart' as solution_2;
import 'dart:io';
import 'dart:math';

main(List<String> arguments) {
  print('Enter the number: ');
  int? n = int.parse(stdin.readLineSync()!);
  if (checkSemiprime(n) != 0) {
    print('$n is semiprime');
  } else {
    print('$n is not semiprime');
  }
}

int checkSemiprime(int n) {
  int count = 0;
  for (int i = 2; count < 2 && i * i <= n; ++i) {
    while (n % i == 0) {
      n = (n / i).round();
      ++count;
    }
  }
  if (n > 1) {
    ++count;
  }
  return count == 2 ? 1 : 0;
}
