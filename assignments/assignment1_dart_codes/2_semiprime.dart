import 'dart:io';

//function to chekc if a number is semiprime or not
bool semiprime(int num) {
  //a number is semiprime if it is product of two prime numbers
  //count will be storing the count of numbers whose product = num
  int count = 0;

  for (int i = 2; count < 2 && i * i <= num; ++i) {
    while (num % i == 0) {
      num = num ~/ i;
      ++count; // Increment count of prime numbers
    }
  }

  // If number is greater than 1, add it to the count variable
  // as it indicates the number remain is prime number
  if (num > 1) ++count;

  // Return '1' if count is equal to '2' else
  // return '0'
  return (count == 2);
}

void main() {
  print("Enter a number: ");
  //input n
  int n = int.parse(stdin.readLineSync()!);
  if (semiprime(n))
    print("$n is a semiprime ");
  else
    print("$n is not a semiprime ");
}
