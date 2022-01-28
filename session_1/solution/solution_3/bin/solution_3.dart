// ignore_for_file: unused_import

import 'package:solution_3/solution_3.dart' as solution_3;
import 'dart:io';
import 'dart:math';
import 'dart:convert';

// ignore: non_constant_identifier_names
int IsPrime(int n) {
  int isPrime = 1;
  if (n == 1 || n == 0) {
    isPrime = 0;
  } else {
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        isPrime = 0;
      }
    }
  }
  return isPrime == 0 ? 0 : 1;
}

void main(List<String> arguments) {
  int sum = 0;
  print('Enter number of elements in Array: ');
  int? arrNum = int.parse(stdin.readLineSync()!);
  var arr = [];
  for (var i = arrNum; i > 0; i--) {
    print('enter element: ');
    int? x = int.parse(stdin.readLineSync()!);
    arr.add(x);
  }
  print('the array is : $arr');

  for (int i = 0; i < arrNum; i++) {
    if (IsPrime(arr[i]) == 1) {
      sum = (sum + arr[i]).round();
    }
  }

  print('the sum of primes in this array is $sum ');
  IsPrime(sum) == 0 ? print('$sum is not a prime') : print('$sum is a prime');


}
