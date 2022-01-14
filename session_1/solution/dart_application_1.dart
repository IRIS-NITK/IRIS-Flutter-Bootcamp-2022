import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'dart:io';

//Print the first N Fibonacci numbers(N is specified by the user).

void main(){
  print("Enter the No of Terms required in the Fibonacci series : ");
  int? N= int.parse(stdin.readLineSync()!);
  if (N==1){
    print(1);
  }else if(N==2){
    int a=1, b=1;
    print("$a $b");
    }else{
      fun(N);
    }

}
void fun(N){
  int f=1,s=1,t;
  t=f+s;
  print("\n\n$f \n$s");
  for(int i=0;i<N-2;i++){
    t=f+s;
    int d,e;
    d=s;
    e=t;
    f=d;
    s=e;
    print("$s");
  }

}
  