// Importing dart:io to implement input from user
import 'dart:io';

// Recursive Function to print Fibonacci Sequence
void printFib(int n, int a, int b){
  if (n == 0){
    return;
  }
  int c = a+b;
  stdout.write("$c ");
  printFib(n-1,b,c);
}

// Main Function
void main(){

  print("\n\n\n################################");

  print("PRINTING FIBONACCI SEQUENCE");

  print("################################\n\n\n");

  stdout.write("Enter number of terms of Fibonacci numbers to print: ");
  int? n = int.parse(stdin.readLineSync()!);   // Taking input from user

  int a = 0;
  int b = 1;

  stdout.write("\n  Fibonacci series upto $n terms: ");

  if(n < 1) print("\nInvalid Input");
  else if (n == 1) stdout.write("$a ");     // Base cases
  else if (n == 2) stdout.write("$a $b ");     // Base cases
  else {
    stdout.write("$a $b ");
    printFib(n-2,a,b);     //Calling the printFib function 
  }
  print("\n\n##################################\n\n\n");
}