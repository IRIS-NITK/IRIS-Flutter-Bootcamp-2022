//Write a program to check whether the given number is semiprime or not

import 'dart:io';

bool isPrime(int n) {
  for (int i = 2; i < n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  if (n == 1) {
    return false;
  } else {
    return true;
  }
}

bool semiPrime(N) {
  int count = 0;
  for (int i = 2; i < N; i++) {
    if (N % i == 0) {
      if (isPrime(i) == true) {
        int y = N;
        while (y % i == 0) {
          //To check repeated prime divisors
          count++;
          y ~/= i;
        }
      } else {
        return false;
      }
    }
  }
  if (count == 2) {
    return true;
  } else {
    return false;
  }
}

void main() {
  bool ans = false;
  print("Enter a number to check if its Semi Prime");
  int? N = int.parse(stdin.readLineSync()!);
  if (N <= 0) {
    print("Invalid Number");
  } else {
    ans = semiPrime(N);
    if (ans == true) {
      print("Yes, $N is a Semi Prime number");
    } else {
      print("No, $N is not a Semi Prime number");
    }
  }
}
