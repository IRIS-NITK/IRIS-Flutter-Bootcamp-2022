import 'dart:io';
void main() {
  print("Enter the number");
  int? num = int.parse(stdin.readLineSync()!);
  int counter=0;
  int factor;
  for(int i=2;i<num;i++) {
    if (num % i == 0) {
      counter++;
    }
  }
      if(counter==2){
        print("It is a Semi Prime Number");
      }
      else if(counter==1){
        for(int i=2;i<num;i++) {
          if (num % i == 0) {
            int counter2=0;
            for(int j=1;j<=i;j++)
              {
                if(i%j==0)
                  {
                    counter2++;
                  }
              }
            if(counter2==2) {
              print("It is a Semi Prime number");
              break;
            }
            else{
              print("Not a semi prime number ");
              break;
            }
          }
        }

      }
      else{
        print("Not a Semi Prime number");
      }

}