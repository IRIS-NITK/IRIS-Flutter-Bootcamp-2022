import 'dart:io';

void isSemiPrime(int n) {
  int original_number = n;
  int count = 0;
  for (int i = 2; i * i <= n; i++) {
    while (n % i == 0) {
      n = n ~/ i;
      count++;
      if (count >= 2) {
        break;
      }
    }
  }

  if (n > 1) {
    count++;
  }

  stdout.write("\n");

  if (count == 2) {
    print("$original_number is a semiprime number!!");
  } else {
    print("$original_number is not a semiprime number!!");
  }
}

void main() {
  print(
      "******** Program to check whether the given number is semiprime or not ********");

  stdout.write("Enter the value of N : ");
  try {
    int n = int.parse(stdin.readLineSync()!);
    if (n <= 0) {
      print("N must be greater than 0!!!");
      return;
    } else {
      isSemiPrime(n);
    }
  } catch (e) {
    print("Please Enter Only Number!!!");
  }
}
