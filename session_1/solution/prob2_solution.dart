//Write a program to check whether the given number is semiprime or not
import 'dart:io';

bool checkSemiprime(int num) {
  int cnt = 0;

  for (int i = 2; cnt < 2 && i * i <= num; ++i)
    while (num % i == 0) num = (num ~/ i);
  ++cnt; // Increment count
  // of prime numbers

  // If number is greater than 1, add it to
  // the count variable as it indicates the
  // number remain is prime number
  if (num > 1) ++cnt;

  // Return '1' if count is equal to '2' else
  // return '0'
  return cnt == 2;
}

// Function to print 'True' or 'False'
// according to condition of semiprime
void semiprime(int n) {
  if (checkSemiprime(n))
    print("true");
  else
    print("False");
}

void main() {
  int N;
  print("Enter the number to check if semiprime");
  N = int.parse(stdin.readLineSync()!);

  semiprime(N);
}
