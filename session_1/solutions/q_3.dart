int checkprime(int z) {
  int x = 0;

  for (int i = 2; i <= z ~/ 2 && x != 1; i++) {
    if (z % i == 0) {
      if (i != z) {
        x = 1;
      }
    }
  }
  return x;
}

void main() {
  var arr = [3, 4, 2, 5, 8, 5];
  int n = arr.length, i = 0, sum = 0, x, y;
  while (i < n) {
    x = 0;
    x = checkprime(arr[i]);
    if (x == 0) {
      sum = sum + arr[i];
    }
    i++;
  }
  y = checkprime(sum);
  if (y == 0) {
    print("sum=$sum is prime number");
  } else {
    print("Sum=$sum is not prime number");
  }
}
