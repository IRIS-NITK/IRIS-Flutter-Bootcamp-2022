import 'dart:io';
import 'dart:core';

bool checkIfSemiPrime(int num) {
  int cnt = 0;
  int d = 2;

  while (num > 1) {
    if (num % d == 0) {
      cnt++;
      num = (num / d).floor();
    }else{
      d++;
    }
  }

  if (cnt == 2) {
    return true;
  }

  return false;
}

void main() {
  stdout.write("Enter a number to check for semiprime :");
  var inputNum = stdin.readLineSync();

  if (inputNum != null) {
    var number = int.parse(inputNum);

    if (checkIfSemiPrime(number)) {
      stdout.write("The number $number is a semiprime.\n");
    } else {
      stdout.write("The number $number is not a semiprime.\n");
    }
  }
}
