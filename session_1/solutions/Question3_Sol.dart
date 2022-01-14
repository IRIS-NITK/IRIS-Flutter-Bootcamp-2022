import 'dart:io';

void main()
{
  get_array();
}

get_array()
{
  print("Enter the number of elements in the array : ");
  int? n = int.parse(stdin.readLineSync()!);
  List<int> array = [];
  for (int i = 1; i <= n; i++)
  {
    print("Enter element $i : ");
    int? ele = int.parse(stdin.readLineSync()!);
    array.add(ele);
  }
  check(array);
}

check(array)
{
  int sum = 0;
  bool result;
  for (int j = 0; j < array.length; j++)
  {
    int num = array[j];
    result = check_prime(num);
    if (result == true)
    {
      sum += num;
    }
  }

  print("The sum of the prime numbers in the array is $sum");
  result = check_prime(sum);
  if (result == true)
  {
    print("Sum of the prime numbers of the array is a prime number");
  }
  else
  {
    print("Sum of the prime numbers of the array is not a prime number");
  }
}

bool check_prime(int N)
{
  if (N < 1)
  {
    return false;
  }
  else
  {
    int count = 0;
    for (int k = 2; k < N; k++)
    {
      if (N % k == 0)
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