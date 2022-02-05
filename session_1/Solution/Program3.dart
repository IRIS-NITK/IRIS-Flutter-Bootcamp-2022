import 'dart:io';

bool isPrime(int n) {
  int count = 0;
  for (int i = 1; i <= n; i++) {
    if (n % i == 0) {
      count++;
    }
  }

  return count == 2;
}

void CheckSumPrime(int length, List<int> array) {
  int sum = 0;
  var prime_numbers = [];
  for (int i = 0; i < length; i++) {
    if (isPrime(array[i])) {
      prime_numbers.add(array[i]);
      sum += array[i];
    }
  }

  if (isPrime(sum)) {
    stdout.write('\n');
    print("Prime elements in the array are : ");
    for (var i in prime_numbers) {
      stdout.write(i);
      stdout.write(' ');
    }

    stdout.write('\n\n');

    print("Sum of these prime elements is : $sum");
    stdout.write('\n');

    print("Therefore,Sum of prime elements of the array is prime.");
  } else {
    print("Sum of prime elements of the array is Not prime.");
  }
}

void main() {
  print(
      "******** Program to check whether the sum of prime elements of the array is prime or not ********");

  try {
    int length;
    List<int> array = [];

    stdout.write("Enter the length of the array : ");

    length = int.parse(stdin.readLineSync()!);

    if (length > 0) {
      print("Enter the elements of the array : ");
      for (int i = 0; i < length; i++) {
        array.add(int.parse(stdin.readLineSync()!));
      }

      CheckSumPrime(length, array);
    } else {
      print("Length of the array must be greater than 0!!!");
    }
  } catch (e) {
    print("Please Enter Only Number!!!");
  }
}
