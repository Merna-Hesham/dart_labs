// =============================================================
// Session 1 | Part 4: Control flow (decisions and loops)
// Run with:  dart run 04_control_flow.dart
// =============================================================

void main() {
  // ---------------------------------------------------------
  // 1) if / else if / else
  // ---------------------------------------------------------
  print('--- if / else ---');
  int temperature = 28;

  if (temperature > 35) {
    print('Very hot');
  } else if (temperature > 25) {
    print('Warm'); // this branch runs
  } else if (temperature > 15) {
    print('Mild');
  } else {
    print('Cold');
  }

  // ---------------------------------------------------------
  // 2) switch statement: compare one value against many cases
  // ---------------------------------------------------------
  print('--- switch ---');
  int day = 3;
  switch (day) {
    case 1:
      print('Monday');
      break; // `break` is required to stop at the end of a case
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday'); // this case runs
      break;
    case 6:
    case 7: // two cases can share the same code
      print('Weekend');
      break;
    default:
      print('Another weekday'); // runs when nothing matches
  }

  // Dart 3 switch EXPRESSION: shorter, returns a value
  String dayType = switch (day) {
    6 || 7 => 'Weekend',
    _ => 'Weekday', // `_` means "anything else"
  };
  print('Day $day is a $dayType');

  // ---------------------------------------------------------
  // 3) for loop: when you know how many times to repeat
  // ---------------------------------------------------------
  print('--- for loop ---');
  for (int i = 1; i <= 5; i++) {
    print('Iteration $i');
  }

  // Multiplication table using a for loop
  print('--- Multiplication table of 7 ---');
  for (int i = 1; i <= 10; i++) {
    print('7 x $i = ${7 * i}');
  }

  // ---------------------------------------------------------
  // 4) for-in loop: go through every item of a collection
  // ---------------------------------------------------------
  print('--- for-in loop ---');
  List<String> languages = ['Dart', 'Kotlin', 'Swift'];
  for (String l in languages) {
    print('Language: $l');
  }

  // ---------------------------------------------------------
  // 5) while loop: repeat while a condition is true
  //    (the condition is checked BEFORE each round)
  // ---------------------------------------------------------
  print('--- while loop ---');
  int countdown = 3;
  while (countdown > 0) {
    print('Countdown: $countdown');
    countdown--; // without this line the loop would never stop!
  }
  print('Liftoff!');

  // ---------------------------------------------------------
  // 6) do-while loop: runs AT LEAST ONCE
  //    (the condition is checked AFTER each round)
  // ---------------------------------------------------------
  print('--- do-while loop ---');
  int tries = 0;
  do {
    tries++;
    print('Try number $tries');
  } while (tries < 3);

  // ---------------------------------------------------------
  // 7) break and continue
  //    break    -> leave the loop completely
  //    continue -> skip to the next iteration
  // ---------------------------------------------------------
  print('--- break and continue ---');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) continue; // skip even numbers
    if (i > 7) break; // stop the loop after 7
    print('Odd number: $i'); // 1, 3, 5, 7
  }

  // ---------------------------------------------------------
  // 8) Nested loops: a loop inside a loop (a small triangle)
  // ---------------------------------------------------------
  print('--- Nested loops ---');
  for (int row = 1; row <= 4; row++) {
    String line = '';
    for (int col = 1; col <= row; col++) {
      line += '* ';
    }
    print(line);
  }
}
