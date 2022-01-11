// Checking whether the sum of prime elements of the array is prime or not

import 'dart:io';

bool prime(int n) {
  if (n == 1) return false;

  for (int i = 2; i < n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void main() {
  print('Please enter the number of values in the List: ');
  int? siz = int.parse(stdin.readLineSync()!);
  var ary = [];

  for (int i = 0; i < siz; i++) {
    int? k = int.parse(stdin.readLineSync()!);
    ary.add(k);
  }

  int sum = 0;
  for (int i = 0; i < siz; i++) {
    if (prime(ary[i])) {
      int k = ary[i];
      sum += k;
    }
  }

  if (prime(sum))
    print('The Sum of Prime Elements of the entered array is PRIME!');
  else
    print('The Sum of Prime Elements of the entered array is NOT PRIME!');
}
