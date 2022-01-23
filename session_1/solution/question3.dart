import 'dart:io';

bool check(int n) {
  for (int i = 2; i * i <= n; i++) if (n % i == 0) return false;
  return true;
}

int input() => int.parse(stdin.readLineSync()!);

void main() {
  print('enter the total');
  int z = input();

  var l = [];
  int sum = 0;

  print("enter the elements of array");

  for (int i = 0; i < z; i++) {
    int a = input();
    if (check(a)) sum += a;
  }
  print((check(sum)
      ? "yes the sum of prime numbers in array is prime and the sum is $sum"
      : "no the sum of prime numbers in array is not prime and the sum is $sum"));
}
