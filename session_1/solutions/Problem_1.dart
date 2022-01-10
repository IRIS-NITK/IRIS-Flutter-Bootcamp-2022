import 'dart:io';

// FUnction to print first N fibonacci numbers
void fibo_n(int n) {
  int a = 0, b = 1;
  int c = 1;
  for (int i = 0; i < n; i++) {
    stdout.write(" ${a}");
    c = a + b;
    a = b;
    b = c;
  }
}

//driver code
int main() {
  stdout.write("Enter the limit for FIbonacci Numbers : ");
  int? n = int.parse(stdin.readLineSync()!);
  print("The First ${n} fibonacci numbers are : ");
  fibo_n(n);
  return 0;
}
