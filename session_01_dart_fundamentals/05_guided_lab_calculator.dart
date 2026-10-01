// =============================================================
// Session 1 | Guided Lab A: Console calculator
// Skills practiced: user input, parsing, null safety, switch,
//                   loops, functions
// Run with:  dart run 05_guided_lab_calculator.dart
// =============================================================

import 'dart:io'; // gives us stdin (read input) and stdout (write output)

void main() {
  print('=== Simple Calculator ===');
  print('Type "q" at any time to quit.\n');

  // Keep asking until the user decides to quit.
  while (true) {
    // STEP 1: read the first number (null means the user typed "q")
    double? first = readNumber('Enter the first number : ');
    if (first == null) break;

    // STEP 2: read the operator
    stdout.write('Enter an operator (+ - * / %): ');
    String? operator = stdin.readLineSync()?.trim();
    if (operator == null || operator.toLowerCase() == 'q') break;

    // STEP 3: read the second number
    double? second = readNumber('Enter the second number: ');
    if (second == null) break;

    // STEP 4: calculate and show the result
    double? result = calculate(first, operator, second);
    if (result == null) {
      print('Could not calculate: check the operator or division by zero.\n');
    } else {
      print('Result: $first $operator $second = $result\n');
    }
  }

  print('Goodbye!');
}

/// Asks the user for a number and keeps asking until the input is valid.
/// Returns `null` if the user typed "q" (quit) or there is no more input.
double? readNumber(String message) {
  while (true) {
    stdout.write(message); // like print, but without a new line
    String? input = stdin.readLineSync()?.trim();

    // readLineSync returns null when there is no more input (Ctrl+D).
    if (input == null || input.toLowerCase() == 'q') return null;

    double? number = double.tryParse(input); // null if it is not a number
    if (number != null) return number;

    print('"$input" is not a valid number. Try again.');
  }
}

/// Performs the math. Returns `null` when the operation is not possible.
double? calculate(double a, String operator, double b) {
  switch (operator) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      if (b == 0) return null; // cannot divide by zero
      return a / b;
    case '%':
      if (b == 0) return null;
      return a % b;
    default:
      return null; // unknown operator
  }
}
