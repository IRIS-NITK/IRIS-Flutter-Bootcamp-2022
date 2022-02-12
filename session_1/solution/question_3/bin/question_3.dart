//Check whether the sum of prime elements of the array is prime or not

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

void main() {
  int ans = 0;
  var arr = [1, 2, 3, 4, 8];
  for (int i = 0; i < arr.length; i++) {
    if (isPrime(arr[i]) == true) {
      ans += arr[i];
    }
  }
  if (isPrime(ans) == true) {
    print("Sum of prime elements of the array is prime");
  } else {
    print("Sum of prime elements of the array is not prime");
  }
}
