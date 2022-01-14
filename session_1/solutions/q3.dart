import "dart:io";
void main (){
  num sum=0;
  List l = (stdin.readLineSync()!).split(
        ' ');
  
  for(int i=0;i<l.length;i++){ 
   if (isprime(int.parse(l[i]))){
     sum+=int.parse(l[i]);
   }
  }
  print(isprime(sum));  
}
bool isprime(x){//to tell weather a number is prime 
  int i=2;
  while (i<=(x+1)/2){
    if (x%i==0){
      return false;
    }
    else {
      i+=1+((i>2) ? 1:0);
    }
  }
  return true;
} 
