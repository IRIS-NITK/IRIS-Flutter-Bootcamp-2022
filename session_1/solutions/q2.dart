import 'dart:io';
void main()
 {  
    double numb = double.parse(stdin.readLineSync()!);
    double n = numb;
    int count=0;
    var i=2;
    while (i<=(n+1)/2 ){//no number can have a prime factor that is greater than n/2(exception:if the number is prime itself)
    if (isprime(i) && n%i ==0){//condition check for weather i is prime and n is devisible by i
      count++;
      n=n/i; //to update and start checking for the next prime factor      
      i=2;
      continue;
   }
    else if(isprime(n)){//to check weather the number is prime(exception case)
      count++;
      n=1;
      i=2;
      continue;
      }
    i+=1+((i>2) ? 1:0);//all prime numbers after 3 come in increaments of multiples of 2
    }
   if (count==2 ){
     print("the number $numb is semi prime ");
   }    
}
bool isprime(x){//to tell weather a number is prime 
  int i=2;
  while (i<=(x+1)/2){
    if (x%i==0){
      return false;
    }
    else {
      i+=1+((i>2) ? 1:0);
    }
  }
  return true;
} 
