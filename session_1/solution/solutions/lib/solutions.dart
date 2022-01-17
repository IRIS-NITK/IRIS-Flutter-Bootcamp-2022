import 'dart:io';

void printFibonacci() {
  int n = _takeInput();
  stdout.write('The n fibonacci numbers are: ');
  int twoback = 0;
  int prev = 1;
  stdout.write('$prev, ');
  for (int i = 0; i <= n - 2; i++) {
    int ele = twoback + prev;
    stdout.write('$ele, ');
    twoback = prev;
    prev = ele;
  }
}

void isSemiPrime() {
  var ans = false;
  int n = _takeInput();
  for (int i = 2; i < n / 2; i++) {
    if ((n % i == 0) && isPrime(i) && isPrime((n / i).round())) ans = true;
  }
  if (ans)
    print('$n is Semi-Prime');
  else
    print('$n is NOT Semi-Prime');
}

bool isPrime(int n) {
  if (n == 1 || n == 0) return false;
  for (int i = 2; i <= n / 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void isSumPrime() {
  var ans = false;
  List arr = _takeArrayInput();
  int sum = 0;
  for (int ele in arr) {
    if (isPrime(ele)) sum += ele;
  }
  if (sum != 0 && isPrime(sum)) ans = true;
  if (ans)
    print('The sum of prime elements of the array: $sum is prime!');
  else
    print('The sum of prime elements of the array: $sum is NOT prime!');
}

int _takeInput() {
  print('Enter a number');
  return int.parse(stdin.readLineSync()!);
}

List _takeArrayInput() {
  print('Enter elements separated by space');
  final regexp = RegExp(r'(?: |, |,)');

  var input = stdin.readLineSync()!;
  List list = [];
  try {
    list = input.split(regexp).map(int.parse).toList();
  } catch (e) {
    print(e);
  }
  return list;
}
