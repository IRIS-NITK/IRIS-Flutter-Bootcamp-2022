import 'dart:ffi';
import "dart:io";
import "dart:core";
import 'dart:convert';

void main() {
  print('Enter no of elements in array');
  int? n = int.parse(stdin.readLineSync()!);
  // ignore: deprecated_member_use_from_same_package
  List<int> list = [];
  int sum = 0;
  print('Enter the array integers:');
  for (int i = 0; i < n; i++) list.add(int.parse(stdin.readLineSync()!));
  for (int j = 0; j < n; j++) {
    if (isPrime(list.elementAt(j))) sum += list.elementAt(j);
  }
  if (isPrime(sum))
    print('The sum of prime elements is prime');
  else
    print('The sum of prime elements is not  prime');
}

bool isPrime(int n) {
  if (n < 2) return false;
  for (int j = 2; j <= (n / 2); j++) {
    if (n % j == 0) return false;
  }
  return true;
}
