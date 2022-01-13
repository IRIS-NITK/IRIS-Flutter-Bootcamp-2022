import 'dart:io';

bool isprime(int n) {
  if (n <= 1) {
    return false;
  }

  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      return false;
    } else {
      return true;
    }
  }

  return true;
}

void main(List<String> args) {
  List<int> ls = [];
  print("enter a number of elements :");
  int n = int.parse(stdin.readLineSync()!);
  ls.add(int.parse(stdin.readLineSync()!));
  for (int i = 1; i < n; i++) {
    ls.add(int.parse(stdin.readLineSync()!) + ls[i - 1]);
  }
  if (isprime(ls[ls.length - 1])) {
    print("its prime");
  } else {
    print("its not a prime");
  }
}
