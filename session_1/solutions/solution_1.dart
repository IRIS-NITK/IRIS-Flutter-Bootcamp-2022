import 'dart:io';

int fibonacci(int n) => n <= 2 ? 1 : fibonacci(n - 2) + fibonacci (n - 1);

main() {
  String output = "";
  print("Enter N : ");
  int? n = int.parse(stdin.readLineSync()!);
  for (int i = 1; i <= n; ++i) {
    output += fibonacci(i).toString() + ", ";
  }
  print(output + "...");
}
