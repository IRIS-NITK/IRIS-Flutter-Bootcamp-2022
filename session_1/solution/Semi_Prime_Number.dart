import 'dart:io';

bool check(int num) {
  if (num == 2)
    return true;
  else if (num % 2 == 0)
    return false;
  else {
    for (int i = 3; i < num; i++) {
      if (num % i == 0) return false;
    }
  }
  return true;
}

void main() {
  int? num = int.parse(stdin.readLineSync()!);
  int i = 2;
  while (i < num) {
    if (check(i)) {
      if (num % i == 0 && check(num ~/ i)) {
        print("$num is a SemiPrime Number.");
        return;
      }
    }
    i++;
  }
  print("$num is not a SemiPrime Number.");
}
