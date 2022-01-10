import 'dart:io';

bool isPrime(int num) {
  if (num == 1) {
    return false;
  }
  if (num < 4) {
    return true;
  }

  for (int i = 2; i * i <= num; i++) {
    if (num % i == 0) {
      return false;
    }
  }
  return true;
}

// driver code
int main() {
  stdout.write("Enter size of the array : ");
  int? size = int.parse(stdin.readLineSync()!);
  int sum = 0;
  var arr = List.generate(size, (index) => index.toInt());
  for (int i = 0; i < size; i++) {
    stdout.write("Enter number ${i + 1} : ");
    arr[i] = int.parse(stdin.readLineSync()!);
  }
  for (int i = 0; i < size; i++) {
    if (isPrime(arr[i])) {
      sum += arr[i];
    }
  }
  if (isPrime(sum)) {
    print("Sum is ${sum} and it is Prime.");
  } else {
    print("Sum is ${sum} and it is not Prime.");
  }
  return 0;
}
