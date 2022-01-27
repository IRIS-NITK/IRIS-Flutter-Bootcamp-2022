// import 'package:question_3/question_3.dart' as question_3;
import 'dart:io';

bool isPrime(int n){

  if(n<2) return false;

  for(int i=2;i<=n/2;i++){
    if(n%i==0) return false;
  }
  return true;
}


void main() {

  print("Enter the length of the array:");
  int? length = int.parse(stdin.readLineSync()!);

  var arr = List.filled(length, 0);

  print("Enter the elements of the array:");
  for(int i=0;i<length;i++){
    arr[i] = int.parse(stdin.readLineSync()!);
  }

  int sum=0;

  for(int i=0;i<arr.length;i++){

    if(isPrime(arr[i])){
      sum+=arr[i];
    }
  }
  
  bool ans = isPrime(sum);

  if(ans==true){
    print('The sum of prime elements of array is prime');
    return;
  }
  print('The sum of prime elements of array is not prime');

}
