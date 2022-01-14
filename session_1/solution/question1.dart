import 'dart:io';

const N = 1e5;

void printFibbonaci(int n) {
  var f = [];
  f.add(0);
  f.add(1);

  for (int i = 2; i < n; i++) {
    f.add(f[i - 1] + f[i - 2]);
  }

  // print(f);
  f.forEach((e)=>print(e));
}

void main() {
  print('enter the value of n');
  int? a = int.parse(stdin.readLineSync()!);
  printFibbonaci(a);
}
