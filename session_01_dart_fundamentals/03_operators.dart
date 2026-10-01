// =============================================================
// Session 1 | Part 3: Operators
// Run with:  dart run 03_operators.dart
// =============================================================

void main() {
  int a = 17;
  int b = 5;

  // ---------------------------------------------------------
  // 1) Arithmetic operators
  // ---------------------------------------------------------
  print('--- Arithmetic ---');
  print('a + b  = ${a + b}'); // 22
  print('a - b  = ${a - b}'); // 12
  print('a * b  = ${a * b}'); // 85
  print('a / b  = ${a / b}'); // 3.4  (division ALWAYS gives a double)
  print('a ~/ b = ${a ~/ b}'); // 3    (integer division)
  print('a % b  = ${a % b}'); // 2    (remainder / modulo)

  // ---------------------------------------------------------
  // 2) Increment and decrement
  // ---------------------------------------------------------
  print('--- Increment / Decrement ---');
  int counter = 0;
  counter++; // counter = counter + 1
  print('After counter++ : $counter'); // 1
  print('Pre-increment ++counter : ${++counter}'); // 2 (increase, then use)
  print('Post-increment counter++ : ${counter++}'); // 2 (use, then increase)
  print('Now counter = $counter'); // 3
  counter--;
  print('After counter-- : $counter'); // 2

  // ---------------------------------------------------------
  // 3) Assignment operators
  // ---------------------------------------------------------
  print('--- Assignment ---');
  int x = 10;
  x += 5; // x = x + 5  -> 15
  x -= 3; // x = x - 3  -> 12
  x *= 2; // x = x * 2  -> 24
  x ~/= 5; // x = x ~/ 5 -> 4
  print('x = $x');

  // ---------------------------------------------------------
  // 4) Relational (comparison) operators -> always give a bool
  // ---------------------------------------------------------
  print('--- Relational ---');
  print('a == b : ${a == b}'); // false
  print('a != b : ${a != b}'); // true
  print('a > b  : ${a > b}'); // true
  print('a <= b : ${a <= b}'); // false

  // ---------------------------------------------------------
  // 5) Logical operators
  // ---------------------------------------------------------
  print('--- Logical ---');
  bool hasId = true;
  bool hasTicket = false;
  print('hasId && hasTicket : ${hasId && hasTicket}'); // AND -> false
  print('hasId || hasTicket : ${hasId || hasTicket}'); // OR  -> true
  print('!hasId             : ${!hasId}'); // NOT -> false

  // ---------------------------------------------------------
  // 6) Ternary (conditional) operator:  condition ? ifTrue : ifFalse
  // ---------------------------------------------------------
  print('--- Ternary ---');
  int score = 72;
  String result = score >= 50 ? 'Pass' : 'Fail';
  print('Score $score -> $result');

  // ---------------------------------------------------------
  // 7) Type test operators: is, is!, as
  // ---------------------------------------------------------
  print('--- Type tests ---');
  Object thing = 'Dart';
  print('thing is String  : ${thing is String}'); // true
  print('thing is! int    : ${thing is! int}'); // true
  String casted = thing as String; // cast: crashes if the type is wrong
  print('Cast result: $casted');

  // ---------------------------------------------------------
  // 8) Operator precedence: use parentheses to be clear
  // ---------------------------------------------------------
  print('--- Precedence ---');
  print('2 + 3 * 4   = ${2 + 3 * 4}'); // 14  (multiplication first)
  print('(2 + 3) * 4 = ${(2 + 3) * 4}'); // 20
}
