import 'dart:io'; 
//Semiprime numbers are those which can be expressed in product of two prime numbers
void checkSemiprime(int n){
  int p=0,primeCheck;
  for(int i=2;i<n;i++) //check for all divisible numbers till itself 
  { 
    if(n%i==0){
      primeCheck=prime(i); //to check if divisor is prime
      if(primeCheck==1)
      p=p+1;
    }
  }
  if(p==2){
  print("$n is Semiprime");}
  else{
  print("$n is not Semiprime");}
}
//program to check for prime number
int prime(int m)
{
  int t=0;
  for(int i=2;i<m;i++){
    if(m%i==0)
    t=t+1;}

  if(t>0){return(0);}
  else{return(1);}
}
//driver code
void main(){
  print("\t\tChecking for SemiPrime numbers");
  print("Enter the number to check:");
  int n = int.parse(stdin.readLineSync()!);
  checkSemiprime(n);
}