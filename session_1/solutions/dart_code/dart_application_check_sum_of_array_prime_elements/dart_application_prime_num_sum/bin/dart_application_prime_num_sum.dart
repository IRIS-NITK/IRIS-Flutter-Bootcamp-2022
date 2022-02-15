import 'dart:io';
import 'dart:core';

bool checkIfPrime(int number) {

  if (number == 1) {
    return false;
  }

  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}

void main() {
  int len = 1;

  stdout.write("Enter the length of the array: ");
  var input = stdin.readLineSync();

  if (input != null) {
    len = int.parse(input);
  }

  var array = List<int>.filled(len, 0);

  for (int i = 0; i < len; i++) {
    stdout.write("Enter value at index $i of the array: ");
    var input = stdin.readLineSync();
    if (input != null) {
      array[i] = int.parse(input);
    }
  }

  int sum = 0;

  for (int i = 0; i < len; i++) {
    if (checkIfPrime(array[i])) {
      sum += array[i];
    }
  }

  if (checkIfPrime(sum)) {
    stdout.write("The sum of prime elements $sum of the array is prime.\n");
  } else {
    stdout.write("The sum of the prime elements $sum of the array is not prime.\n");
  }
}
