import 'dart:io';
import 'dart:core';

bool isPrime(int num) {
  if (num == 2)
    return true;
  else if (num % 2 == 0 || num == 1)
    return false;
  else {
    int i = 3;
    while (i < num) {
      if (num % i == 0)
        return false;
      else
        i += 2;
    }
  }
  return true;
}

void main() {
  String? ss = stdin.readLineSync()!;
  var list = ss.split(" ");
  int sum = 0;
  for (String element in list) {
    if (isPrime(int.parse(element))) sum += (int.parse(element));
  }
  if (isPrime(sum))
    print("True");
  else
    print("False");
}
