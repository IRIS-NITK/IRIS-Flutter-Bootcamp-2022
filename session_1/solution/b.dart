import 'dart:io';

void main(List<String> args) {
  print("enter a num :");
  int n = int.parse(stdin.readLineSync()!);
  int cnt = 0;
  for (int i = 2; cnt < 2 && i * i <= n; i++) {
    while (n % i == 0) {
      n = n ~/ i;
      cnt++;
    }
  }
  if (n > 1) {
    cnt++;
  }

  if (cnt == 2) {
    print("its a semi-prime");
  } else {
    print("its not semi prime");
  }
}
