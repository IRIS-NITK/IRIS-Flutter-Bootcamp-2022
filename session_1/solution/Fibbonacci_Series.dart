import 'dart:io';
void main() {
  int? n = int.parse(stdin.readLineSync()!);
  int curr = 1;
  int prev = 0;
  for (int i = 1; i <= n; i++) {
    stdout.write("$curr ");
    curr += prev;
    prev = curr - prev;
  }
}
