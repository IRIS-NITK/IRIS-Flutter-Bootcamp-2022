import 'dart:io';

void main() {
  takeInput();
}

check(arr) {
  int sum = 0;
  bool res;
  for (int j = 0; j < arr.length; j++) {
    int x = arr[j];
    res = checkPrime(x);
    if (res == true) {
      sum += x;
    }
  }
  print("Sum of prime numbers in the array: $sum");
  res = checkPrime(sum);
  if (res == true) {
    print("Sum of prime numbers of the array is prime");
  } else {
    print("Sum of prime numbers of the array is not prime");
  }
}

bool checkPrime(int x) {
  int count = 0;
  if (x > 1) {
    for (int i = 2; i < x; i++) {
      if (x % i == 0) {
        count += 1;
      }
    }
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

takeInput() {
  print("Enter number of elements of array");
  int? N = int.parse(stdin.readLineSync()!);
  List<int> arr = [];
  for (int i = 0; i < N; i++) {
    print("Enter element ${i + 1}");
    int? x = int.parse(stdin.readLineSync()!);
    arr.add(x);
  }
  check(arr);
}
