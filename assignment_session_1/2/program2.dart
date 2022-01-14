import "dart:io";
class semi{
    var number;
    bool if_semiprime(int n){
        int cnt = 0;
        for(int i = 2; cnt < 2 && i*i <= n; i++){
            while(n%i == 0){
                n = n ~/ i;
                cnt++;
            }
        }
        if(n > 1){
            cnt++;
        }
        return cnt == 2;
    }
    void semiprime(int n){
        if(if_semiprime(n)){
            print("The given number is a semi-prime number. \n");
        }
        else{
            print("The given number is not a semi-prime number. \n");
        }
    }
}

void main(){
    var ans = new semi();
    print("Program to check whether the given number is semiprime or not. \n");
    print("Enter n \n");
    ans.number = int.parse(stdin.readLineSync()!);
    ans.semiprime(ans.number);
}