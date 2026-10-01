// =============================================================
// Session 2 | Part 1: Functions
// Run with:  dart run 01_functions.dart
// =============================================================

void main() {
  // ---------------------------------------------------------
  // 1) Basic function: return type, name, parameters
  // ---------------------------------------------------------
  int total = add(3, 4);
  print('add(3, 4) = $total');

  sayHello(); // a function with no parameters and no return value

  // ---------------------------------------------------------
  // 2) Positional OPTIONAL parameters  [ ]
  // ---------------------------------------------------------
  print(describe('Ali')); // age is not provided
  print(describe('Mona', 21)); // age is provided

  // ---------------------------------------------------------
  // 3) NAMED parameters  { }  (very common in Flutter!)
  // ---------------------------------------------------------
  print(createUser(name: 'Omar', age: 20)); // order does not matter
  print(createUser(age: 25, name: 'Laila', city: 'Alexandria'));

  // ---------------------------------------------------------
  // 4) Default values
  // ---------------------------------------------------------
  print(power(2)); // exponent defaults to 2  -> 4
  print(power(2, 10)); // 1024

  // ---------------------------------------------------------
  // 5) Arrow syntax: for functions with a single expression
  // ---------------------------------------------------------
  print('square(6) = ${square(6)}');
  print('isEven(7) = ${isEven(7)}');

  // ---------------------------------------------------------
  // 6) Returning more than one value (Dart 3 records)
  // ---------------------------------------------------------
  var (min, max) = findMinMax([4, 9, 1, 7]);
  print('Min: $min, Max: $max');

  // ---------------------------------------------------------
  // 7) Recursion: a function that calls itself
  // ---------------------------------------------------------
  print('5! = ${factorial(5)}'); // 120
  print('Fibonacci(8) = ${fibonacci(8)}'); // 21

  // ---------------------------------------------------------
  // 8) Scope: variables live only inside their { } block
  // ---------------------------------------------------------
  int outside = 1;
  {
    int inside = 2;
    print('Inside block: $outside and $inside');
  }
  // print(inside); // ERROR: `inside` does not exist out here
  print('Outside block: $outside');
}

/// A function that takes two ints and returns an int.
int add(int a, int b) {
  return a + b;
}

/// `void` means the function returns nothing.
void sayHello() {
  print('Hello from a function!');
}

/// Optional positional parameter: wrapped in [ ] and must be nullable
/// (or have a default value).
String describe(String name, [int? age]) {
  if (age == null) return '$name (age unknown)';
  return '$name is $age years old';
}

/// Named parameters: wrapped in { }.
/// `required` forces the caller to provide the value.
/// A parameter with a default value (or nullable) can be skipped.
String createUser({
  required String name,
  required int age,
  String city = 'Cairo', // default value
}) {
  return 'User{name: $name, age: $age, city: $city}';
}

/// Default value for a positional parameter.
int power(int base, [int exponent = 2]) {
  int result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

/// Arrow syntax: `=> expression;` is short for `{ return expression; }`
int square(int n) => n * n;
bool isEven(int n) => n % 2 == 0;

/// A record `(int, int)` lets a function return several values together.
(int, int) findMinMax(List<int> numbers) {
  int min = numbers.first;
  int max = numbers.first;
  for (int n in numbers) {
    if (n < min) min = n;
    if (n > max) max = n;
  }
  return (min, max);
}

/// Recursion: always needs a BASE CASE (when to stop).
int factorial(int n) {
  if (n <= 1) return 1; // base case
  return n * factorial(n - 1); // recursive case
}

int fibonacci(int n) {
  if (n <= 1) return n; // base cases: fib(0)=0, fib(1)=1
  return fibonacci(n - 1) + fibonacci(n - 2);
}
