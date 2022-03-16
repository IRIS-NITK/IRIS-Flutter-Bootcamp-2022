import 'dart:io';
// import 'dart:convert';
// import 'dart:core';

void printFirstNFibonaciiNumbers(int N) {
  int p1 = 0, p2 = 1;
  if (N <= 0) {
    print("Invalid Input");
  } else if (N == 1) {
    print(p1);
  } else if (N == 2) {
    print(p1);
    print(p2);
  } else if (N >= 3) {
    print(p1);
    print(p2);
    for (int i = 3; i <= N; i++) {
      int p3 = p1 + p2;
      p1 = p2;
      p2 = p3;
      print(p3);
    }
  }
}

void main() {
  int N;
  print("Enter the number of fibonacii numbers required");
  N = int.parse(stdin.readLineSync()!);

  printFirstNFibonaciiNumbers(N);
}
