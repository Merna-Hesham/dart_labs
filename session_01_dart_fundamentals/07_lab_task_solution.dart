// =============================================================
// Session 1 | LAB TASK (instructor solution)
//   Part 1: Number guessing game
//   Part 2: Temperature converter
// Skills practiced: input, loops, null safety, control flow, functions
// Run with:  dart run 07_lab_task_solution.dart
// =============================================================

import 'dart:io';
import 'dart:math'; // for Random

void main() {
  // A small menu that lets the student pick which part to run.
  while (true) {
    print('\n=== Lab Task Menu ===');
    print('1) Number guessing game');
    print('2) Temperature converter');
    print('0) Exit');
    stdout.write('Choose: ');

    String? choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        guessingGame();
        break;
      case '2':
        temperatureConverter();
        break;
      case '0':
      case null: // no more input
        print('Goodbye!');
        return;
      default:
        print('Invalid choice, try again.');
    }
  }
}

// -------------------------------------------------------------
// PART 1: Number guessing game
// The computer picks 1..100. The player has 7 tries and gets hints.
// -------------------------------------------------------------
void guessingGame() {
  const int maxTries = 7;
  final Random random = Random();
  final int secret = random.nextInt(100) + 1; // nextInt(100) gives 0..99
  int tries = 0;
  bool won = false;

  print('\nI am thinking of a number between 1 and 100.');
  print('You have $maxTries tries.');

  while (tries < maxTries) {
    stdout.write('Guess #${tries + 1}: ');
    String? line = stdin.readLineSync();
    if (line == null) return; // no more input (e.g. Ctrl+D): stop the game
    int? guess = int.tryParse(line);

    // Invalid input does not cost a try.
    if (guess == null) {
      print('Please enter a whole number.');
      continue;
    }

    tries++;

    if (guess == secret) {
      won = true;
      break;
    } else if (guess < secret) {
      print('Too low!');
    } else {
      print('Too high!');
    }
  }

  if (won) {
    print('Correct! You found $secret in $tries tries.');
  } else {
    print('Game over. The number was $secret.');
  }
}

// -------------------------------------------------------------
// PART 2: Temperature converter
// Celsius <-> Fahrenheit <-> Kelvin
// -------------------------------------------------------------
void temperatureConverter() {
  print('\n--- Temperature Converter ---');
  print('1) Celsius -> Fahrenheit');
  print('2) Fahrenheit -> Celsius');
  print('3) Celsius -> Kelvin');
  stdout.write('Choose: ');
  String? option = stdin.readLineSync()?.trim();

  stdout.write('Enter the temperature: ');
  double? value = double.tryParse(stdin.readLineSync() ?? '');

  if (value == null) {
    print('That is not a valid number.');
    return;
  }

  switch (option) {
    case '1':
      double f = value * 9 / 5 + 32;
      print('$value °C = ${f.toStringAsFixed(2)} °F');
      break;
    case '2':
      double c = (value - 32) * 5 / 9;
      print('$value °F = ${c.toStringAsFixed(2)} °C');
      break;
    case '3':
      double k = value + 273.15;
      print('$value °C = ${k.toStringAsFixed(2)} K');
      break;
    default:
      print('Invalid option.');
  }
}
