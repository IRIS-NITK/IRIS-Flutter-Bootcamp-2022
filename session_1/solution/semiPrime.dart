// Importing packages dart:io for user input and dart:math for the sqrt() function
import 'dart:io';
import 'dart:math';

// Defining an isSemiPrime function to check if passed number is semiprime.
bool isSemiPrime(int n){

  int countFact = 0, j = 0;
  for(int i = 1; i<= sqrt(n); i++){            // Basically this loop counts the no. of factors of n, before sqrt(n).
    if(n%i == 0){                              // If this count equals 2, we conclude that the number is semiprime.
      countFact++;                             // This is because a semiprime n has 4 factors (1, prime#1, prime#2, and n)
      j = i;                                   // out of which 1 and prime#1 are before sqrt(n), Thus count being 2.
    }                                          // Exception, this algorithm does not work for cubes of primes.
  }                                            
                                               
  return countFact == 2 && n != pow(j, 3)? true : false;        

}

// Main Function
void main(){

  print("\n\n\n###############################################");
  print("Checking if Input Number is Semiprime");
  print("###############################################\n\n\n");

  stdout.write("Enter number to check if semiprime: ");
  int? n = int.parse(stdin.readLineSync()!);   // Taking input from user

  if(isSemiPrime(n)) print("\n$n is semi prime.");
  else print("\n$n is not semi prime.");

  print("\n\n#########################################\n\n\n");
}