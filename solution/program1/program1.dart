import 'dart:io';

void fibonacci(int n) {
  int f0 = 1, f1 = 1, f2;
  if (n > 0) {
    stdout.write("\nFibbonacci Series : ");
    while (n > 0) {
      f2 = f1 + f0;
      f0 = f1;
      f1 = f2;
      stdout.write("$f0 ");
      n--;
    }
    print("\n");
  } else {
    print("\nInvalid 'N' !\n");
  }
}

void main() {
  print("\nProgram to print first N fibonacci numbers!");
  stdout.write("\nEnter 'N' value : ");
  int? n = int.parse(stdin.readLineSync()!);
  fibonacci(n);
}
