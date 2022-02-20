import 'dart:io';

int rPrintFibonacci(int n)
{
  if( n <= 1) {
    return n;
  }

  return (rPrintFibonacci(n - 1) + rPrintFibonacci(n - 2));

}

void printFibonacci(int n)
{
  int first = 0, second = 1;
  int next = first + second;

  if(n == 1)
    stdout.write("$first ");
  if(n >=2)
    stdout.write("$first $second ");

  for(int j = 2; j < n; j++)
  {
    stdout.write("$next ");
    first = second;
    second = next;
    next = first + second;
  }
}

void main() {

  stdout.write("Enter the series limit : ");
  int? n = int.parse(stdin.readLineSync()!); //input limit

  //iterative method
  printFibonacci(n);

  //recursive method
  /*for(int i = 0; i < n; i++) {
    stdout.write("${rPrintFibonacci(i)} ");
  }*/
}
