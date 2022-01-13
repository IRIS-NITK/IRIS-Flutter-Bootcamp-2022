//Check whether the sum of prime elements of the array is prime or not
import 'dart:io';

bool isPrime(int N) {
  int count = 0;
  for (int i = 1; i * i < N; i++) {
    if (N % i == 0) count++;
  }
  if (count == 1)
    return true;
  else
    return false;
}

void checkIfSumOfPrimeisPrime(List<int> list) {
  int sum = 0;
  for (int i = 0; i < list.length; i++) {
    if (isPrime(list[i])) {
      sum += list[i];
    }
  }
  if (isPrime(sum)) {
    print("Sum is also prime");
  } else {
    print("Sum is not prime");
  }
}

void main() {
  List<int> list = [];

  //Number of elements in the array
  print("Enter the number of elements");
  int N = int.parse(stdin.readLineSync()!);

  //Getting the numbers from the input
  print("Enter the elements of the list");
  for (int i = 0; i < N; i++) {
    list.add(int.parse(stdin.readLineSync()!));
  }

  checkIfSumOfPrimeisPrime(list);
}
