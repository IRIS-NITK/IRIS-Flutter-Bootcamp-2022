import "dart:io";
void main() {
  print("Enter The Number Of Elements to be Printed");
  int? n = int.parse(stdin.readLineSync()!);
  int sum;
  int n1, n2, n3;
  n1 = 0;
  n2 = 1;
  for (int i = 0; i < n; i++) {
    if (i <= 1) {
      print(i);
    }
    else {
      n3 = n1 + n2;
      n1 = n2;
      n2 = n3;
      print(n3);
    }
  }
}
