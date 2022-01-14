import 'dart:io';

bool checkPrime(int num){
   
  for(int i = 2;i<=num~/2;i++){
    if(num%i == 0){
      return false;
    }
  }
  
  return true;
}


void checkarr(List<int> list){
  int sum=0;

  for (int i = 0; i < list.length; i++) {
    if (checkPrime(list[i])&&list[i]!=1)
    sum += list[i];
  }

  print(sum);
  
  if(checkPrime(sum))
  print('The sum of prime elements is prime');
  else
  print('The sum of prime elements is not prime');

}

void main() {
  var list = <int>[];
  print("Enter the number of elements");
  int n = int.parse(stdin.readLineSync()!);
  
  print("Enter an array: ");
  
  for (int i = 0; i < n; i++) 
  list.add(int.parse(stdin.readLineSync()!));

  checkarr(list);
  
}