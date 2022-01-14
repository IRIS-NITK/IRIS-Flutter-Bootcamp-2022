import 'dart:io';

void check(int n){
  int count = 0;

  for (int i=2;count<2&&i*i<=n;++i){
    while(n%i==0){
      n~/=i;
      count++;
    }
  }

  if(n>1)
  count++;

  if(count==2)
  print ('It is a semi-prime');
  else
  print ('It is not a semi-prime');

}

void main() {
  int n;
  print('Enter a number:');
  n=int.parse(stdin.readLineSync().toString());
  check(n);
}