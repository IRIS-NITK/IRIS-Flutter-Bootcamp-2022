void semiprime(int num) {
  int x = 0, y = num;
  for (int i = 2; x < 2 && num >= i * i; i++) {
    while (num % i == 0) {
      x++;
      num = num ~/ i;
    }
  }
  if (num > 1) {
    x++;
  }
  if (x == 2) {
    print("$y is semiprime number");
  } else {
    print("$y is not a semiprime number");
  }
}

void main() {
  int n = 10;
  semiprime(n);
}
