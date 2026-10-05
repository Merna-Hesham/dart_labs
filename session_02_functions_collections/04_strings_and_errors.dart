// =============================================================
// Session 2 | Part 5: Strings in depth and error handling
// Run with:  dart run 05_strings_and_errors.dart
// =============================================================

void main() {
  // stringsDemo();
  errorHandlingDemo();
}

// -------------------------------------------------------------
// STRINGS
// -------------------------------------------------------------
void stringsDemo() {
  print('===== STRINGS =====');

  String text = 'Flutter is Fun';

  print('Length         : ${text.length}');
  print('Upper / Lower  : ${text.toUpperCase()} / ${text.toLowerCase()}');
  print('Char at 0      : ${text[0]}');
  print('Starts with F  : ${text.startsWith('F')}');
  print('Ends with Fun  : ${text.endsWith('Fun')}');
  print('Index of "is"  : ${text.indexOf('is')}');
  print('Substring(0,7) : ${text.substring(0, 7)}');
  print('Replace        : ${text.replaceAll('Fun', 'Awesome')}');
  print('Split          : ${text.split(' ')}'); // string -> list
  print('Join           : ${['a', 'b', 'c'].join('-')}'); // list -> string
  print('Pad left       : ${'7'.padLeft(3, '0')}'); // 007
  print('Repeat         : ${'ab' * 3}'); // ababab

  // Strings are immutable: methods return a NEW string
  String original = 'hello';
  String shouted = original.toUpperCase();
  print('Original stays : $original, new one: $shouted');

  // Practical example: count the vowels
  print('Vowels in "Mobile Development": ${countVowels('Mobile Development')}');
}

int countVowels(String text) {
  const String vowels = 'aeiou';
  int count = 0;
  for (String char in text.toLowerCase().split('')) {
    if (vowels.contains(char)) count++;
  }
  return count;
}

// -------------------------------------------------------------
// ERROR HANDLING: try / on / catch / finally / throw
// -------------------------------------------------------------
void errorHandlingDemo() {
  print('\n===== ERROR HANDLING =====');

  // 1) Basic try / catch
  try {
    int zero = 0;
    int result = 10 ~/ zero; // integer division by zero throws an error
    print('Result: $result');
  } catch (e) {
    print('1) Caught an error: $e');
  }

  // 2) `on` catches a SPECIFIC type of error
  try {
    int number = int.parse('abc'); // throws a FormatException
    print(number);
  } on FormatException catch (e) {
    print('2) Not a number! Details: ${e.message}');
  }

  // 3) finally ALWAYS runs, whether there was an error or not
  try {
    print('3) Working...');
  } catch (e) {
    print('Error: $e');
  } finally {
    print('3) Cleanup done (finally always runs)');
  }

  // 4) Throwing your own errors with `throw`
  try {
    withdraw(balance: 100, amount: 500);
  } on InsufficientFundsException catch (e) {
    print('4) ${e.message}');
  }

  // 5) Range error when using a wrong index
  try {
    List<int> items = [1, 2, 3];
    print(items[10]);
  } on RangeError catch (e) {
    print('5) Wrong index: ${e.message}');
  }

  // 6) Safe alternative: avoid the error with a check or tryParse
  int? maybe = int.tryParse('abc');
  print('6) tryParse gives $maybe instead of crashing');
}

/// Our own exception class (a first taste of OOP, covered in Session 3).
class InsufficientFundsException implements Exception {
  final String message;
  InsufficientFundsException(this.message);
}

double withdraw({required double balance, required double amount}) {
  if (amount > balance) {
    throw InsufficientFundsException(
      'Cannot withdraw $amount: balance is only $balance',
    );
  }
  return balance - amount;
}
