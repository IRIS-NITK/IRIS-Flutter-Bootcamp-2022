bool isprime(num n) {
  if (n == 1) {
    return false;
  }
  for (int i = 2; i < n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}

bool sumofprimes(List<int> a) {
  int sum = 0;
  for (int i = 0; i < a.length; i++) {
    if (isprime(a[i])) {
      sum += a[i];
    }
  }
  return isprime(sum);
}

void main() {
  List<int> a = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  if (sumofprimes(a)) {
    print("the sum of prime elements is prime ");
  } else {
    print("the sum of prime elements is not prime ");
  }
}
