import 'dart:io';

int fibTerm(int n) {
  if (n == 1 || n == 2) {
    return 1;
  }

  return fibTerm(n - 1) + fibTerm(n - 2);
}

void main() 
{
  //Please enter smaller numbers as my algorithm is quite naive
  stdout.write("Enter number of terms you want to print : ");
  var inputNum = stdin.readLineSync();

  if(inputNum != null)
  {
    var numFibTerms = int.parse(inputNum);

    for (int t = 1; t <= numFibTerms; t++) 
    {
    stdout.write("Fibonacci term $t is ${fibTerm(t)}\n");
    }
  }
}
