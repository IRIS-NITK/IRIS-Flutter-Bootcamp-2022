import 'dart:io';

//Function to check a prime number
bool checkPrime(int num) {
  int count = 0;
  bool res;
  for (int i = 2; i < num; i++) {
    if (num % i == 0) {
      count++;
    }
  }
  if (count == 0 && num != 0 && num != 1) {
    res = true;
  } else {
    res = false;
  }
  return res;
}

//Function to check semiprime number
bool semiprime(int num) {
  int d1 = 0, d2 = 0;
  bool res;
  for (int i = 2; i < num; i++) {
    if (checkPrime(i) == true && num % i == 0) {
      d1 = i; //First prime factor
      d2 = num ~/ d1; //Second factor
      break;
    }
  }
  if (checkPrime(d2) == true) //Checking if second factor is prime
    res = true;
  else
    res = false;
  return res;
}

void main() {
  print("Enter an integer: ");
  int n = int.parse(stdin.readLineSync()!);
  bool res = semiprime(n);
  if (res == true)
    print("$n is semiprime.");
  else
    print("$n is not semiprime");
}
