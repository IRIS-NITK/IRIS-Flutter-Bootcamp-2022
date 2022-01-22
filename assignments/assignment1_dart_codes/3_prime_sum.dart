import 'dart:io';

//Function to check prime numbers
bool checkPrime(int num) {
  bool res = true;
  //repeat a loop from t to sqrt(num)
  for (int i = 2; i * i < num; i++) {
    //if i divides num,then the number is not prime,so break from the loop
    if (num % i == 0) {
      res = false;
      break;
    }
  }
  //return bool value of res
  return res;
}

//Checking prime numbers in an array and summing them
bool prime_nums(List<int> arr) {
  int sum = 0;
  //repeat a loop for all elements of arr
  for (int i = 0; i < arr.length; i++) {
    //if that number is prime and that num is not 1 then add that element to the sum
    if (checkPrime(arr[i]) && arr[i] != 1) sum += arr[i];
  }
  //check if the sum is now a prime number or not and return the value
  return checkPrime(sum);
}

void main() {
  print("Enter number of elements");
  //input size of array
  int n = int.parse(stdin.readLineSync()!);
  print("Enter an array: ");
  //array declaration
  var arr = <int>[];
  //input array elements
  for (int i = 0; i < n; i++) {
    arr.add(int.parse(stdin.readLineSync()!));
  }
  //call the function prime_nums
  if (prime_nums(arr))
    print("Sum of prime elements is prime\n");
  else
    print("Sum of prime elements is non-prime\n");
}
