import 'dart:io';

void fibonacci(int n) {
  int first = 0, second = 1;
  for (int i = 0; i < n; i++) {
    if (i == 0)
      print("$first ");
    else if (i == 1)
      print("$second ");
    else {
      int num = first + second;
      print("$num ");
      first = second;
      second = num;
    }
  }
}

void main() {
  var input = stdin.readLineSync(), n;
  if(input != null)
    n = int.parse(input);
  fibonacci(n);
}
