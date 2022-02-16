import 'dart:io';

void main(List<String> args) {
  int n = int.parse(stdin.readLineSync()!);
  int x = 1;
  for (int i = 1; i <= n; i++) {
    x = x * i;
    print(x);
  }
}
