//Print the first N Fibonacci numbers(N is specified by the user).

import 'dart:io';

void fibonacci(N) {
  int a = 0;
  int b = 1;
  int ans;
  print("The first $N Fibonacci numbers are ");
  print(b);
  for (int i = 0; i < N - 1; i++) {
    ans = a + b;
    print(ans);
    a = b;
    b = ans;
  }
}

void main() {
  print("Enter the number of Fibonacci numbers you want ");
  int? N = int.parse(stdin.readLineSync()!);
  if (N <= 0) {
    print("Invalid Number");
  } else {
    fibonacci(N);
  }
}
