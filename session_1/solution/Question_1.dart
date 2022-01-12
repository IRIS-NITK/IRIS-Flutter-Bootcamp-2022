import 'dart:io';

void main() {
  int N = takeInput();
  runSeries(N);
}

int takeInput() {
  print("Enter number of terms of the series");
  int? N = int.parse(stdin.readLineSync()!);
  return N;
}

void runSeries(int n) {
  int a = 0;
  int b = 1;
  int c = a + b;
  if (n < 1) {
    print("Invalid input");
  } else {
    for (int i = 1; i <= n; i++) {
      print(a);
      a = b;
      b = c;
      c = a + b;
    }
  }
}
