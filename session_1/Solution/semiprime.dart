import 'dart:io';

bool checkSemiprime(int n) {
  int count = 0;
  for (int i = 2; count < 2 && i * i <= n; i++) {
    while (n % i == 0) {
      n = (n / i).floor();
      count++;
    }
  }

  if (n > 1) {
    count++;
  }
  return count == 2;
}

void main() {
  print("Enter the number to check:");
  var input = stdin.readLineSync(), n;
  if (input != null) n = int.parse(input);
  if (checkSemiprime(n))
    print("$n is semiprime");
  else
    print("$n is not semiprime");
}
