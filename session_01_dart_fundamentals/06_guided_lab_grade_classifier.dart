// =============================================================
// Session 1 | Guided Lab B: Grade classifier
// Skills practiced: if / else if, ternary, for loop, null safety
// Run with:  dart run 06_guided_lab_grade_classifier.dart
// =============================================================

import 'dart:io';

void main() {
  print('=== Grade Classifier ===');

  // STEP 1: ask how many students we want to classify
  stdout.write('How many students? ');
  int count = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (count <= 0) {
    print('Nothing to do. Please enter a positive number.');
    return; // leaves main early
  }

  int passed = 0;
  double sum = 0;

  // STEP 2: read a mark for each student
  for (int i = 1; i <= count; i++) {
    int mark = readMark('Enter mark for student $i (0-100): ');

    String grade = classify(mark);
    String status = mark >= 50 ? 'Pass' : 'Fail'; // ternary operator

    print('  Student $i: $mark -> Grade $grade ($status)');

    sum += mark;
    if (mark >= 50) passed++;
  }

  // STEP 3: summary
  double average = sum / count;
  print('\n--- Summary ---');
  print('Students : $count');
  print('Passed   : $passed');
  print('Failed   : ${count - passed}');
  print('Average  : ${average.toStringAsFixed(1)}');
}

/// Keeps asking until the user enters a whole number from 0 to 100.
int readMark(String message) {
  while (true) {
    stdout.write(message);
    String? line = stdin.readLineSync();
    if (line == null) exit(0); // no more input: stop the program cleanly
    int? mark = int.tryParse(line);

    if (mark != null && mark >= 0 && mark <= 100) return mark;
    print('  Invalid mark. Enter a whole number between 0 and 100.');
  }
}

/// Converts a numeric mark to a letter grade.
String classify(int mark) {
  if (mark >= 90) {
    return 'A';
  } else if (mark >= 80) {
    return 'B';
  } else if (mark >= 70) {
    return 'C';
  } else if (mark >= 60) {
    return 'D';
  } else {
    return 'F';
  }
}
