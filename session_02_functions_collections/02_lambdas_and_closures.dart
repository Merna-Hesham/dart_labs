// =============================================================
// Session 2 | Part 2: Anonymous functions, closures,
//                     functions as values
// Run with:  dart run 02_lambdas_and_closures.dart
// =============================================================

void main() {
  // ---------------------------------------------------------
  // 1) Functions are objects: store one in a variable
  // ---------------------------------------------------------
  int Function(int, int) multiply = (int a, int b) => a * b;
  print('multiply(3, 4) = ${multiply(3, 4)}');

  // `typedef` gives a function type a readable name
  Operation subtract = (a, b) => a - b;
  print('subtract(10, 4) = ${subtract(10, 4)}');

  // ---------------------------------------------------------
  // 2) Pass a function as an argument (higher-order function)
  // ---------------------------------------------------------
  print('apply add      : ${apply(6, 3, (a, b) => a + b)}');
  print('apply divide   : ${apply(6, 3, (a, b) => a ~/ b)}');
  print('apply a named function: ${apply(6, 3, subtract)}');

  // ---------------------------------------------------------
  // 3) Return a function from a function
  // ---------------------------------------------------------
  Operation adder = makeOperation('+');
  Operation multiplier = makeOperation('*');
  print('makeOperation("+") on (5,2): ${adder(5, 2)}');
  print('makeOperation("*") on (5,2): ${multiplier(5, 2)}');

  // ---------------------------------------------------------
  // 4) Anonymous function with a body ({ })
  // ---------------------------------------------------------
  List<int> numbers = [1, 2, 3];
  numbers.forEach((n) {
    // Body with several statements
    int doubled = n * 2;
    print('Number $n doubled is $doubled');
  });

  // ---------------------------------------------------------
  // 5) CLOSURE: a function that remembers variables from the
  //    place where it was created
  // ---------------------------------------------------------
  Function counterA = makeCounter();
  Function counterB = makeCounter(); // independent from counterA

  print('counterA: ${counterA()}'); // 1
  print('counterA: ${counterA()}'); // 2
  print('counterA: ${counterA()}'); // 3
  print('counterB: ${counterB()}'); // 1 (has its own copy of `count`)

  // Another closure example: a multiplier factory
  var triple = makeMultiplier(3);
  var tenTimes = makeMultiplier(10);
  print('triple(5)   = ${triple(5)}'); // 15
  print('tenTimes(5) = ${tenTimes(5)}'); // 50
}

/// A function type alias: "a function taking two ints and returning an int".
typedef Operation = int Function(int a, int b);

/// Takes a function as its third parameter and calls it.
int apply(int a, int b, Operation operation) {
  return operation(a, b);
}

/// Returns a different function depending on the symbol.
Operation makeOperation(String symbol) {
  switch (symbol) {
    case '+':
      return (a, b) => a + b;
    case '*':
      return (a, b) => a * b;
    default:
      return (a, b) => 0;
  }
}

/// The inner function keeps using `count` even after
/// makeCounter() has finished: that is a closure.
int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

int Function(int) makeMultiplier(int factor) {
  return (int value) => value * factor;
}
