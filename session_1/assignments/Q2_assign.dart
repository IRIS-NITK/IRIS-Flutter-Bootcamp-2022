import 'dart:math';
import 'dart:io';

void main(List<String> args) {
  print("input a number ");
  String? name = stdin.readLineSync();
  try {
    assert(name is String);
    int num = int.parse(name!);
    is_subprime(num);
  } catch (e) {
    print("👀 ❗❗input is not integer❗❗ 👀");
    print(e);
    exit(-1);
  }
  print(is_subprime(18));
}

// returns true if nimber is a subprime //
bool is_subprime(int n) {
  var r = pow(n, 0.5);
  r = r.round();
  for (var i = 2; i < r + 1; i++) {
    if (n % i == 0) {
      var i2 = n / i;
      return is_prime(i) || is_prime(i2);
    }
  }
  return false;
}

// returns true if number is prime //
bool is_prime(var num) {
  if (num == 2 || num == 3) {
    return false;
  }
  if (num < 2 || num % 2 == 0) {
    return false;
  }
  if (num < 9) {
    return true;
  }
  if (num % 3 == 0) {
    return false;
  }
  var r = pow(num, 0.5);
  r = r.round();
  int f = 5;
  while (f <= r) {
    if (num % f == 0) {
      return false;
    }
    if (num % (f + 2) == 0) {
      return false;
    }
    f = f + 6;
  }
  return true;
}
