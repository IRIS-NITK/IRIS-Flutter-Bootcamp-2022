import 'dart:io';

bool is_Prime(num n) {
  if (n <= 1) {
    return false;
  } else {
    for (var i = 2; i < n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }
}

void main(List<String> args) {
  print("Enter the number of elements:");
  int x = int.parse(stdin.readLineSync()!);
  var a = List.empty(growable: true);
  a.length = x;
  print("Enter the array elements:");
  for (var i = 0; i < x; i++) {
    a[i] = int.parse(stdin.readLineSync()!);
  }
  num s = 0;
  for (var i = 0; i < x; i++) {
    if (is_Prime(a[i])) {
      s = s + a[i];
    }
  }
  if (is_Prime(s)) {
    print("The sum of prime elements is $s which is a prime number");
  } else {
    print("The sum of prime elements is $s which is not a prime number");
  }
}
