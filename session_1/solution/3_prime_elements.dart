import 'dart:io';

//Function to check prime numbers
bool checkPrime(int num) {
  int count = 0;
  bool res;
  for (int i = 2; i < num; i++) {
    if (num % i == 0) {
      count++;
    }
  }
  if (count == 0) {
    res = true;
  } else {
    res = false;
  }
  return res;
}

//Checking prime numbers in an array and summing them
bool prime_elements(List<int> list) {
  int sum = 0;
  for (int i = 0; i < list.length; i++) {
    if (checkPrime(list[i]) && list[i] != 1) sum += list[i];
  }
  //print(sum);
  return checkPrime(sum);
}

void main() {
  print("Enter number of elements");
  int n = int.parse(stdin.readLineSync()!);
  print("Enter an array: ");
  var arr = <int>[];
  for (int i = 0; i < n; i++) arr.add(int.parse(stdin.readLineSync()!));
  bool res = prime_elements(arr);
  if (res == true)
    print("Sum of prime elements is prime");
  else
    print("Sum of prime elements is non-prime");
}
