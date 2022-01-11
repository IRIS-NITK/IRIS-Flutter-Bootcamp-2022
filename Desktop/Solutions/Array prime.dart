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
  print("Enter the number of elements in the array");
  int n=int.parse(stdin.readLineSync()!);
  var array =<int>[];
  int counts=1;
  while(n!=0){
    print("Enter the value of number ${counts}");
    int? j=int.parse(stdin.readLineSync()!);
    counts++;
    array.add(j);
    n--;
  }
  int ans=0;
  for(int i in array){
    if(is_prime(i)){
      ans+=i;
    }
  }
  if(is_prime(ans)){
    print("The sum of prime numbers of the array is ${ans}, which is a prime");
  }
  else{
    print("The sum of prime numbers of the array is ${ans}, which is not a prime");
  }
}