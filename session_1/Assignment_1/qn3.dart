bool prime(int val) {
  if (val == 0 || val == 1) {
    return false;
  } else {
    for (int i = 2; i < val; i++) {
      if (val % i == 0) {
        return false;
      }
    }
  }
  return true;
}

bool sumprimes(List<int> arr) {
  int sum = 0;
  int len = arr.length;
  for (int i = 0; i < len; i++) {
    if (prime(arr[i])) {
      sum += arr[i];
    }
  }
  if (prime(sum)) {
    return true;
  } else {
    return false;
  }
}

void main() {
  List<int> arr = [2, 6, 8, 9, 74, 21, 5, 45, 212, 2, 67];
  if (sumprimes(arr)) {
    print("Sum of primes in the array is a prime");
  } else {
    print("Sum of primes in the array is not a prime");
  }
}
