import 'dart:io';

//function to print the fibonacci series
void fibonacci_series(int n) {
  //initialize initial variables a,b
  int a = 0;
  int b = 1;
  //print the values of a ,b
  print(a);
  print(b);
  int c;
  //loop for n-2 times
  for (int i = 0; i < n - 2; i++) {
    //add a and b and store the value in c and print its value
    c = a + b;
    print(c);
    //update the values of a and b
    a = b;
    b = c;
  }
}

void main() {
  print("Enter no. of terms to be printed: ");
  //input n
  int n = int.parse(stdin.readLineSync()!);
  print("The $n fibonacci terms are: ");
  //call the function
  fibonacci_series(n);
}
