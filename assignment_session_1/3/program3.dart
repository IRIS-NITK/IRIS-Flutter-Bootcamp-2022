import "dart:io";
import "dart:math";
import "dart:convert";

class prime{
    bool if_prime(int n){
        int count = 0;
        for(int i = 2; i<=sqrt(n).toInt(); i++){
            if(n%i == 0){
                count++;
            }
        }
        if(count > 0){
            return false;
        }
        else{
            return true;
        }
    }
    void sum_prime(List<int>arr){
        int sum = 0;
        for(int i = 0; i<arr.length; i++){
            if(if_prime(arr[i])){
                sum = sum + arr[i];
            }
        }
        if(if_prime(sum)){
            print("Sum of the prime elements in the list is prime.\nSum = ${sum}");
        }
        else{
            print("Sum of the prime elements in the list is not prime.\nSum = ${sum}");
        }
    }
}

void main(){
    print("Program to check whether the sum of prime elements of the array is prime or not \n");
    print("Enter the number of elements of the array. \n");
    int n = int.parse(stdin.readLineSync()!);
    var list = new List.filled(n, 0);
    print("Enter the elements. \n");
    for(int i = 0; i<n; i++){
        list[i] = int.parse(stdin.readLineSync()!);
    }
    var ans = new prime();
    ans.sum_prime(list);
}