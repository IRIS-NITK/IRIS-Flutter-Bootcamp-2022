import 'dart:io';
import 'dart:math';

void main()
{
  int number = input_number();
  bool semi = check_if_semiprime(number);
  if (semi == true)
  {
    print("$number is a semiprime number");
  }

  else
  {
    print("$number is not a semiprime number");
  }
  
}

int input_number()
{
  print("Enter a number = ");
  int? number = int.parse(stdin.readLineSync()!);
  return number;
}

check_if_semiprime(int number)
{
  int s = sqrt(number).toInt();
  for (int i = 2; i <= s; i++)
  {
    if (number % i == 0)
    {
      bool div1 = check_if_prime(i);
      if (div1 == true)
      {
        int j = (number / i).truncate().toInt();
        if (i * j == number && i != j)
        {
          bool div2 = check_if_prime(j);
          if (div2 == true)
          {
            return true;
          }
        }
      }
    }
  }
  return false;
}

check_if_prime(int n)
{
  if (n < 1)
  {
    return false;
  }
  else
  {
    int count = 0;
    for (int i = 2; i < n; i++)
    {
      if (n % i == 0)
      {
        count += 1;
      }
    }
    if (count == 0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}