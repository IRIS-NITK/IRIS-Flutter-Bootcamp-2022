import 'dart:io' show stdin;

void main() {
  print("Enter a number: ");

  // Converts the input string into an integer.
  int? n = int.parse(stdin.readLineSync()!);
  print(" ");
  // For every number upto n prints the corresponding Fibonacci number.
  for (int i = 1; i < n + 1; i++) {
    print(fibonacci(i));
  }
  print(" ");
}

// Computes the nth Fibonacci number.
int fibonacci(int n) {
  return n < 2 ? n : (fibonacci(n - 1) + fibonacci(n - 2));
}
