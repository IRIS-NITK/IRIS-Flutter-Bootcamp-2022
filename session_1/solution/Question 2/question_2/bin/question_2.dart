import 'package:question_2/question_2.dart' as question_2;
import 'dart:io';

bool isPrime(int n){
  for(int i=2;i<=n/2;i++){
    if(n%i==0) return false;
  }
  return true;
}

bool isSemiPrime(int n){
    int d1=0,d2=0;

    if(n<2) return false;

    for(int i=2;i<=n/2;i++){
      if(n%i==0){
        d1=i;
        d2=n~/i;
        break;
      }
    }
    print('d1 = $d1');
    print('d2 = $d2');
    if(isPrime(d1)&&isPrime(d2)&&d1!=0){
      return true;
    }
    return false;
}



void main() {
  
  print("Enter an integer to test for semiprime:");
  int? number = int.parse(stdin.readLineSync()!);
  bool isSemi = isSemiPrime(number);
  
  print("The number $number is  $isSemi");

}
