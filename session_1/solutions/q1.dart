import 'dart:io';



void main() {
 
  
    int n = int.parse(stdin.readLineSync()!);
    int x=0,y=1;
    print("${x}");
    print("${y}");
    for (var j=1;j<=(n-2);j++){
      int z = x+y;
      x=y;
      y=z;
      print("${z}");
    }

  

}