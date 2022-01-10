import 'dart:io';

bool isPrime(int num) {
  if (num == 1) {
    return false;
  }
  if (num < 4) {
    return true;
  }

  for (int i = 2; i * i <= num; i++) {
    if (num % i == 0) {
      return false;
    }
  }
  return true;
}

bool isSemiPrime(int num) {
  for (int i = 2; i * i <= num; i++) {
    if (num % i == 0) {
      int div = num ~/ i;
      if (isPrime(i) && isPrime(div)) {
        stdout.write("${num} = ${i} * ${div} = > ");
        return true;
      }
    }
  }
  return false;
}

int main() {
  print("Program to check whether a given number is Semi-prime or not :");
  print(
      " Semi-prime :  a number that is product of 2 prime numbers like 6,9,15 etc");
  stdout.write("Enter a number : ");
  int? num = int.parse(stdin.readLineSync()!);
  if (isSemiPrime(num)) {
    print(" ${num} is semi-Prime");
  } else {
    print("${num} is not semi-Prime ");
  }
  return 0;
}
