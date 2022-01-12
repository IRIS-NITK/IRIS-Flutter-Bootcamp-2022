import 'dart:io';
import 'dart:math';

void main() {
  int N = takeInput();
  bool res = check(N);
  if (res == true) {
    print("Semiprime number");
  } else {
    print("Not a semiprime number");
  }
}

int takeInput() {
  print("Enter number");
  int? N = int.parse(stdin.readLineSync()!);
  return N;
}

check(int N) {
  int l = sqrt(N).toInt();
  for (int i = 2; i <= l; i++) {
    if (N % i == 0) {
      bool res_1 = checkPrime(i);
      if (res_1 == true) {
        int j = N ~/ i;
        if ((j * i == N) && (j != i)) {
          bool res_2 = checkPrime(j);
          if (res_2 == true) {
            return true;
          }
        }
      }
    }
  }
  return false;
}

checkPrime(int n) {
  if (n > 1) {
    int count = 0;
    for (int i = 2; i < n; i++) {
      if (n % i == 0) {
        count += 1;
      }
    }
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
