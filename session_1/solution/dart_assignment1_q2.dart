import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'dart:io';
void main(){
  print("Enter the number which has to be checked for semiprime : ");
  int? N= int.parse(stdin.readLineSync()!);
  List<int> L=[];
  int c=0;
  for(int i=2;i<=(N/2);i++){
    if(N%i==0){
      L.add(i);
      c=c+1;
    }
  }
  if(c==2 || c==1){
    print("The Number $N is a Semiprime Number");
  }else{
    print("The Number $N is not semiprime");
  }
}