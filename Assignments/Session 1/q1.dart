import 'dart:io';

void fibonacci(int num){
  int f1 = 1, f2 = 1, f3;

  print('The fibonacci sequence is:');

  stdout.write(f1);
  stdout.write(",");
  stdout.write(f2);
  stdout.write(",");

  while(num-2 != 0){
    f3 = f1+f2;
    num--;

    stdout.write(f3);
    stdout.write(",");
    f1 = f2;
    f2 = f3;
  }
}
void main() {
  print('Please enter a number:');
  int fibnum = int.parse(stdin.readLineSync().toString());
  fibonacci(fibnum);
}
