// Importing dart:io to implement input from user
import 'dart:io';


// isPrime function to check if a number is prime
bool isPrime(n){

  int count = 0;
  if(n == 1){
    count = 1;
  }else{
    for(int i = 2; i*i <= n; i++){
      if (n % i == 0){
        count++;
      }
    }
  }
  return count == 0 ? true : false;
}


// Main Function
void main(){

  print("\n\n\n##########################################################");
  print("Checking if Sum of primes of array is also Prime");
  print("##########################################################\n\n\n");

  stdout.write("Enter array to check (eg. 1 4 3 55 3): ");
  String? n = stdin.readLineSync();   // Taking input from user

  if(n != null){
    var list = n.split(" ");
    List<int> arr = [];                                                       // Convert user input into array/list data 
    list.forEach((element) => {arr.add(int.parse(element))});


    int sum = 0;
    arr.forEach((element) => {sum += isPrime(element) ? element : 0});        //get sum of prime elements of list
    
    if(isPrime(sum)) print("\nSum of the primes of the array ($sum) is also prime");      // Output if sum of prime elements 
    else print("\nSum of the primes of the array ($sum) is not prime");                   // of array is prime or not
    



  }else print("Null input not accepted");

  
  

  print("\n\n#############################################################\n\n\n");

}