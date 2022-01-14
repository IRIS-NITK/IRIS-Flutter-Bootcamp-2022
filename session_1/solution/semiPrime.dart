import "dart:io";

void main() {
  print("Enter a number");
  int? n = int.parse(stdin.readLineSync()!);
  bool semi = semiPrime(n);
  if (semi)
    print("$n is a semi-prime number");
  else
    print("$n is not a semi-prime number");
}

bool semiPrime(int n) {
  if (n == 1) return false;
  if (n < 1) {
    print('you have entered an invalid number');
    return false;
  }
  if (isPrime(n)) return false;
  for (int i = 4; i <= (n / 2); i++) {
    if ((n % i == 0) && (!isPrime(i))) return false;
  }
  return true;
}

bool isPrime(int n) {
  for (int j = 2; j <= (n / 2); j++) {
    if (n % j == 0) return false;
  }
  return true;
}
