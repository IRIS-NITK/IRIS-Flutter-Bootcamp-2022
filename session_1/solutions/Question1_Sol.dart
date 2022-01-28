import 'dart:io';

void main()
{
  
  int x = get_input();
  Fibonacci_Series(x);

}

int get_input()
{

  print("Enter the number of terms of the Fibonacci series you want to know: ");
  int? n = int.parse(stdin.readLineSync()!);
  return n;

}

void Fibonacci_Series(int n)
{

  if (n < 1)
  {
    print("Invalid input");
  }

  else
  {
    int a = 0;
    int b = 1;
    int c = a + b;
    for (int i = 1; i <= n; i++)
    {
      print(a);
      a = b;
      b = c;
      c = a + b;
    }
  }
}