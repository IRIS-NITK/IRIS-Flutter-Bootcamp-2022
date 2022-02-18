import 'dart:io';

List fibbonacci(int n) {
  List fib = [0, 1];
  //initialised zeroth term as 0 so index and term no. would be same
  for (int i = 2; i <= n; i++) {
    fib.add(fib[i - 1] + fib[i - 2]);
  }
  return fib;
}

void main() {
  print("enter the no. of fibbonacci");
  int? n = int.parse(stdin.readLineSync()!);
  print("fibbonacci series is");
  List ser = fibbonacci(n);
  for (int i = 1; i <= n; i++) {
    print(ser[i]);
  }
}
