import 'dart:io';

class fibo{
    var number;
    fibonacci(int n){
        int f1 = 0; 
        int f2 = 1;
        if(n<1){
            return;
        }
        print("The first n fibonacci numbers are :");
        print("\n${f1} \n");
        for(int i = 1; i<n; i++){
            print("${f2} \n");
            int next = f1+f2;
            f1 = f2;
            f2 = next;
        }
        return;
    }
}


void main(){
    var ans = new fibo();
    print("Program to print the first n fibonacci numbers \n");
    print("Enter n \n");
    ans.number = int.parse(stdin.readLineSync()!);
    ans.fibonacci(ans.number);
}