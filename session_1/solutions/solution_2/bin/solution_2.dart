import 'dart:io';

bool isPrime(int n)
{
  for(int i = 2; i <= n / 2; i++)
  {
    if(n % i == 0){
      return false;      //n is composite
    }
  }

  return true;             //n is prime
}

bool isSemiPrime(int n)
{
  int div_1 = 1, div_2 = n;        // divisors of n

  for(int i = 2; i <= n / 2; i++)  //finding divisors of n (if they exist)
      {
    if(n % i == 0){
      div_1 = i;                 //divisors found!
      div_2 = n ~/ i;
      break;
    }
  }

  if(div_1 == 1){                  //n is prime
    return false;
  }

  return (isPrime(div_1) && isPrime(div_2)); //check if divisors are prime

}

void main() {

  stdout.write("Enter a number : ");
  int? n = int.parse(stdin.readLineSync()!); //input n

  bool semiprime = isSemiPrime(n);

  if(semiprime){
    stdout.write("$n is semi-prime");
  }
  else{
    stdout.write("$n is not semi-prime");
  }
}
