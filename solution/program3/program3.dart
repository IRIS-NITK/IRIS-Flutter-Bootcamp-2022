import 'dart:io';

bool check_prime(int x) {
  if (x > 1) {
    int count = 1;
    for (int i = 1; i * i <= x; i++) {
      if ((x % i) == 0) count += 1;
      if (count > 2) return false;
    }
    if (count == 2)
      return true;
    else
      return false;
  } else
    return false;
}

void check_sum_prime(List<int> ls) {
  int i, sum = 0;
  for (i = 0; i < ls.length; i++) {
    if (check_prime(ls[i])) {
      sum += ls[i];
    }
  }
  if (check_prime(sum))
    print("\nSum of prime elements in above list is a prime ( Sum : $sum )\n");
  else
    print(
        "\nSum of prime elements in above list is not a prime ( Sum : $sum )\n");
}

void main() {
  print(
      "\nCheck whether the sum of prime elements of the array is prime or not!\n");
  stdout.write("Enter the n.o of elements in list : ");
  int? n = int.parse(stdin.readLineSync()!);
  var list = List.filled(n, 0);
  int i;
  for (i = 0; i < n; i++) {
    int? data = int.parse(stdin.readLineSync()!);
    list[i] = data;
  }
  check_sum_prime(list);
}
