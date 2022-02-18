import 'dart:io';

bool check_prime(int x) {
  if (x > 1) {
    int count = 1;
    for (int i = 1; i * i <= x; i++) {
      if ((x % i) == 0) count += 1;
      if (count > 2) return false;
    }
    if (count == 2)
      return true;
    else
      return false;
  } else
    return false;
}

void check_semiprime(int n) {
  int i;
  for (i = 2; (i * i) <= n; i++) {
    if ((n % i == 0) && check_prime(i)) {
      if (((i * (n ~/ i)) == n) && (check_prime(n ~/ i))) {
        print("\n$n is a semi-prime number ($i x ${(n ~/ i)} = $n)!\n");
        break;
      } else {
        print("\n$n is not a semi-prime number!\n");
        break;
      }
    }
  }
  if ((i * i) > n) print("\n$n is not a semi-prime number!\n");
}

void main() {
  print("\nProgram to check whether the given number is semiprime or not!\n");
  stdout.write("Enter N value : ");
  int? num = int.parse(stdin.readLineSync()!);
  check_semiprime(num);
}
