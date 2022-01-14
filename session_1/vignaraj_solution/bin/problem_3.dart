import 'dart:io' show stdin;
import 'dart:math' show sqrt;

void main() {
  print('Please enter the array of numbers:');

  // Taking in an array of numbers as space separated values.
  final input = stdin.readLineSync()!;

  // Converting the input string into an list of integers.
  final listOfNumbers = input.split(' ').map(int.parse).toList();

  // Inititalizing the sum.
  int sumofprimes = 0;

  // Adds the sum of prime elements in the array.
  for (int num in listOfNumbers) {
    if (isprime(num)) {
      sumofprimes = sumofprimes + num;
    }
  }

  print("");

  // Checks if the sum is prime and prints results accordingly.
  if (isprime(sumofprimes)) {
    print("The sum of prime elements of the array is Prime!");
  } else {
    print("The sum of prime elements of the array is NOT Prime!");
  }

  print(" ");
}

// Returns True if a number is Prime, else True.
bool isprime(int n) {
  if (n == 2) {
    return true;
  }

  for (int i = 2; i < sqrt(n) + 1; i++) {
    if (n % i == 0) {
      return false;
    }
  }

  return true;
}
