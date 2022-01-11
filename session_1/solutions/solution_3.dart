import 'dart:math';

bool checkprime(int num) {
  int factors = 0;
  for (int j = 1; j <= num; j++) {
    if ((num % j) == 0) {
      factors++;
    }
  }
  if (factors == 2) {
    return true;
  } else {
    return false;
  }
}

void main() {
  List<int> arr = [2, 3, 2, 2];
  int n = arr.length;
  int sum = 0;
  for (int i = 0; i < n; i++) {
    if (checkprime(arr[i])) {
      sum = sum + arr[i];
    }
  }
  if (checkprime(sum)) {
    print("True");
  } else {
    print("False");
  }
}
