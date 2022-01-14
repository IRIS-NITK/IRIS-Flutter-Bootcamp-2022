// import 'package:question_1/question_1.dart' as question_1;
import 'dart:io'; 


void fibonacci(int n){

  if(n<=0){
    print("Entered numbered should be greater than zero");
    return;
  } 

  int f0=0,f1=1,result=0, count=0;
  
  if(n==1){
    print('0');
    return;
  }
  else{
    print('0');
    print('1');
    if(n==2){ 
      return;
    }
  }
  count=2;
  result = f0+f1;

  while(count<n){
    result=f0+f1;
    f0=f1;
    f1=result;
    print('$result');
    count+=1;
  }
  return;
}

void main() {

  print("Enter the number till which the Fibonacci series should be printed:");

  int? number = int.parse(stdin.readLineSync()!);

  fibonacci(number);
}
