import 'dart:io' show stdin;
import 'dart:math' show sqrt;

void main() {
  print("Enter a number: ");

  // Converts the input string into an integer.
  int? n = int.parse(stdin.readLineSync()!);

  // Initialize the number of factors of the given number.
  int factors = 0;

  // List to store the factors.
  List allfact = [];

  // Finding all factors (upto n/2 for n).
  for (int i = 2; i < n / 2 + 1; i++) {
    if (n % i == 0) {
      factors = factors + 1;
      allfact.add(i);
    }
    // If number of factors > 2 then the number cannot be a semiprime.
    if (factors != 2) {
      print("\nNot a semiprime!\n");
      return;
    }
  }

  // Checking if the the 2 factors in the list of factors are prime.
  for (int i in allfact) {
    // if even one of the factors is not prime, the number is not a semiprime.
    if (!isprime(i)) {
      print("\nNot a semiprime!\n");
      return;
    }
    // in case the above if condition is never true.
    print("\nThe number is a semiprime!\n");
    return;
  }
}

// Checks if a number is prime.
bool isprime(int n) {
  if (n == 2) {
    return true;
  }

  for (int i = 2; i < sqrt(n) + 1; i++) {
    if (n % i == 0) {
      return false;
    }
  }

  return true;
}
