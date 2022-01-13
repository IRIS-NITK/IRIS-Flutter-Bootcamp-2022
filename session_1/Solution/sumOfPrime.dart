import 'dart:io';

bool isPrime(int n) {
  int i, m = 0;

  if(n == 1)
    return false;
  m = n ~/ 2;
  for (i = 2; i <= m; i++) {
    if (n % i == 0) {
      return false;
    }
  }

  return true;
}

void isSumPrime(List<int> arr, int n) {
  var sum = 0;
  for (var i = 0; i < n; i++) {
    if(isPrime(arr[i]))
      sum += arr[i];
  }
  if(isPrime(sum))
    print("Sum ($sum) is prime.");
  else
    print("Sum ($sum) not prime.");
}

void main() {
  print("Enter the size of array:");
  var input = stdin.readLineSync(), n, sum = 0;
  if (input != null) n = int.parse(input);
  var arr = <int>[];
  print("Enter elements of array:");
  for (var i = 0; i < n; i++) {
    var k, number;
    do {
      k = stdin.readLineSync();
      if (k != null) number = int.parse(k);
    } while (k == null);
    arr.add(number);
    sum = (sum + number) as int;
  }

  isSumPrime(arr, n);
}
