import 'dart:io'; 

int isPrime(int m) //fn to check if a number is prime
{
  int t=0;
  for(int i=2;i<m;i++){
    if(m%i==0)
    t=t+1;}

  if(t>0){return(0);}
  else{return(1);}
}
void checkSumPrime(List<int> array){
  int i, sum = 0;
  for (i = 0; i < array.length; i++) {
    if (isPrime(array[i])==1) {
      sum += array[i];
    }
  }
  //print("\nSum of the array is $sum");
  if (isPrime(sum)==1)
    print("Sum of prime elements is $sum which is a prime");
  else
    print("Sum of prime elements is $sum which is not a prime");
}

void main(){
  print("\t\tChecking whether the sum of prime elements of the array is prime or not");
  print("Enter the number of elements of array: ");
  int n = int.parse(stdin.readLineSync()!);
  var array = <int>[]; //declaration of array
  print("Now, Enter the array elements: ");
  for(int i=0;i<n;i++){ //Entering array elements
    int j = int.parse(stdin.readLineSync()!);
    array.add(j);
  }

  // print("Array that has been entered:");
  // for(int p=0;p<n;p++){
  //   print(array[p]);
  // }
  checkSumPrime(array);

}