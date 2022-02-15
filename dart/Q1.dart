import 'dart:io';

void pallindrome(int n) {
  int x = 0;
  int z = 1;
  print(x);
  print(z);
  int c;
  for (int i = 0; i < n - 2; i++) {
    c = x + z;
    print(c);
    x = z;
    z = c;
  }
}

void main() {
  print("Enter no. of terms");
  int? n = int.parse(stdin.readLineSync()!);
  pallindrome(n);
}
