import 'dart:io';

//Function to check whether a given number is Prime 
bool is_prime(int n){
  if(n==1) return false;
  for(int i=2;i*i<=n;i++){
    if(n%i==0) return  false;
  }
  return true;
}

void main(){
  bool ans=false;     //Flag
  print("Enter the value of n");
  int? n=int.parse(stdin.readLineSync()!);
  int a=1,b=n;        //Declaring 2 variables to store the values of 2 divisors.Initially it has value 1 and n.
  for(int i=2;i*i<=n;i++){
    if(n%i==0){
      a=i;
      b=n~/i;
      break;
    }
  }
  if(is_prime(a)&&(is_prime(b))) ans=true;
  if(ans) print("${n} is a Semi-prime");
  else print("${n} is not a Semi-prime");
}