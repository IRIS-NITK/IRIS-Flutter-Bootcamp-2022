int fib(int x, int y) {
  int z;
  z = x + y;
  print(y);
  return z;
}

void main() {
  int n = 5, i = 0, a = 0, b = 1, c;
  while (i < n) {
    c = fib(a, b);
    a = b;
    b = c;
    i = i + 1;
  }
}
