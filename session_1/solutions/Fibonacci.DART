import 'dart:io'; 

void Fibonacci(int n){
  int i, third, first=0, second=1;
  if(n<3){ //corner case: if it's less than 3
    if(n==1){print(first);}
    else if(n==2){print("$first\n$second");}
    else{print('Non zero!!');}
    return;
  }
  print(first);
  print(second);
  for(int i = 2 ;i < n; i++){ //fibonacci loop
    third = first + second;
    print(third);
    first = second;
    second = third;
  }
}

void main(){
  print("\t\t Program to print N fibonacci numbers");
  int input; 
  print("Enter a non-zero positive number till which we need to find fibonacci number: ");
  input = int.parse(stdin.readLineSync()!);
  Fibonacci(input); //control goes to fibonacci
}