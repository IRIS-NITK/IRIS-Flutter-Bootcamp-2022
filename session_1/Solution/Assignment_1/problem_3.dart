import 'dart:io';
import 'dart:convert';

final int max = 100000;
var prime = List.filled(max, true);

void sieve() {
  prime[0] = prime[1] = false;
  for (int i = 2; i < max; i++) {
    if (prime[i]) {
      for (int j = 2 * i; j < max; j += i) prime[j] = false;
    }
  }
}

bool checkSum(List<int> arr) {
  int sum = 0;
  for (int i = 0; i < arr.length; i++) {
    if (prime[arr[i]]) sum += arr[i];
  }
  if (prime[sum])
    return true;
  else
    return false;
}

void main() {
  sieve();
  print("Enter the size of Array:");
  int? n = int.parse(stdin.readLineSync()!);
  List<int> arr = [];
  print("Enter $n Elements:");
  for (int i = 0; i < n; i++) {
    int? v = int.parse(stdin.readLineSync()!);
    arr.add(v);
  }
  if (checkSum(arr))
    print("The Sum of Prime Elements is Prime");
  else
    print("The Sum of Prime Elements is not Prime");
}
