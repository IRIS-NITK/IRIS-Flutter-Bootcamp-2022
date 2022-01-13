import 'dart:io';

void fibonacci(int n){
  List<BigInt> lis=[];             //Using BigInt to avoid int overflow.
  lis.add(BigInt.parse('0'));
  lis.add(BigInt.parse('1'));
  lis.add(BigInt.parse('1'));
  for(int i=3;i<=n;i++){
    lis.add(lis[i-1]+lis[i-2]);
  }
  print("The first ${n} fibonacci numbers are:");
  for(int i=1;i<=n;i++){
    print("${lis[i]}");
  }
}


void main(){
  print("Enter the value of n");
  int? n=int.parse(stdin.readLineSync()!);
  fibonacci(n);
}