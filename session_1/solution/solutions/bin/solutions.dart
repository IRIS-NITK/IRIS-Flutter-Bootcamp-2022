import 'package:solutions/solutions.dart' as solutions;
import 'dart:io';

void main(List<String> arguments) {
  print('Choose which program you would like to run');
  print('1. Print n Fibonacci Numbers');
  print('2. Is n Semi-Prime?');
  print('3. Is the sum of prime elements a prime?');
  int choice = int.parse(stdin.readLineSync()!);
  switch (choice) {
    case 1:
      solutions.printFibonacci();
      break;
    case 2:
      solutions.isSemiPrime();
      break;
    case 3:
      solutions.isSumPrime();
      break;
    default:
      print('Enter a valid number');
      break;
  }
}
