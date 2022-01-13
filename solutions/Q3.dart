
import 'dart:convert';
import 'dart:io';
void main() {
  List<int> list = [];
  //print(list);
  List<int> plist = []; // a list add prime numbers
  //list.add(2);
  //print(list);
  int sum = 0;
  for (int i = 0; i < 5; i++) {
    print("Enter the number ");
    int? n = int.parse(stdin.readLineSync()!);
    list.add(n);
  }
  print(list);
  for (int i = 0; i < 5; i++) {
    int num = list.elementAt(i);
    int counter = 0;
    for (int j = 1; j <= num; j++) {
      if (num % j == 0) {
        counter++;
      }
    }
    print(counter);
    if (counter == 2) {
      plist.add(num);
    }
  }
  for(int i=0;i<plist.length;i++){
    int num=plist.elementAt(i);
    sum=sum+num;
  }
  int counter2=0;
  for(int i=1;i<=sum;i++){
    if(sum%i==0){
      counter2++;
    }
  }
  if (counter2==2){
    print("Sum is a prime number $sum");
  }
  else{
    print("Sum is not a prime number $sum");
  }
}