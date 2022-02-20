import 'dart:io';

bool isPrime(int n)
{
  if(n <= 1)
    return false;

  for(int i = 2; i <= n / 2; i++) {

      if(n % i == 0){
        return false;
      }

    }
  return true;
}

void main() {

  var numArray = [22, 6, 60, 10, 9];
  stdout.write("Array : $numArray \n");
  int sumOfPrimes = 0;

  for(int i = 0; i < numArray.length; i++){                //iterate through the array
    if(isPrime(numArray[i]))  sumOfPrimes += numArray[i];   //add prime elements
  }

  if(sumOfPrimes > 0){

    if(isPrime(sumOfPrimes)){
      stdout.write("Sum of prime elements is prime");
    }
    else{
      stdout.write("Sum of prime elements is not prime");
    }

  }
  else{
    stdout.write("No prime elements in the array");
  }

}
