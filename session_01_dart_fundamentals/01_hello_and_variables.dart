// =============================================================
// Session 1 | Part 1: Hello Dart, comments, variables
// Run with:  dart run 01_hello_and_variables.dart
// =============================================================

// A single-line comment starts with two slashes.

/* A multi-line comment
   can span several lines. */

/// A documentation comment (three slashes) describes the code below it.
/// Tools like VS Code show it when you hover over the function.

/// Every Dart program starts running from the `main` function.
void main() {
  // ---------------------------------------------------------
  // 1) print: sends text to the console
  // ---------------------------------------------------------
  // print('Hello, Dart!');

  // ---------------------------------------------------------
  // 2) Variables with `var` (type is inferred from the value)
  // ---------------------------------------------------------
  var name = 'Merna'; // Dart infers String
  // print(name);
  // print('$name, ${name.runtimeType}');
  var age = 22; // Dart infers int
  age = 23; // OK: a `var` can be reassigned
  // print(age);
  // age = 'twenty'; // ERROR: once inferred as int, it stays int

//   // ---------------------------------------------------------
//   // 3) Explicit types (clearer when you want to be specific)
//   // ---------------------------------------------------------
  String course = 'Mobile Development';
  int labNumber = 1;
  double gpa = 3.75;
  bool isPassing = true;
//
//   // ---------------------------------------------------------
//   // 4) String interpolation: put values inside a string
//   //    $variable        -> for simple names
//   //    ${expression}    -> for any expression
//   // ---------------------------------------------------------
//   print('Name: $name, Age: $age');
//   print('Next year $name will be ${age + 1}.');
//   print('Course: $course | Lab: $labNumber | GPA: $gpa | Passing: $isPassing');

//   // ---------------------------------------------------------
//   // 5) final: assigned ONCE, at runtime (value may be unknown
//   //    until the program runs)
//   // ---------------------------------------------------------
//   final DateTime startedAt = DateTime.now();
//   // startedAt = DateTime.now(); // ERROR: final cannot be reassigned
//   print('Program started at: $startedAt');
//
//   // ---------------------------------------------------------
//   // 6) const: a COMPILE-TIME constant (value must be known
//   //    before the program runs)
//   // ---------------------------------------------------------
//   const double pi = 3.14159;
//   const int maxStudents = 40;
//   print('Pi = $pi, Max students = $maxStudents');

//   // final vs const in one line:
//   //   final -> "set once while running"
//   //   const -> "known while compiling, never changes"
//
//   // ---------------------------------------------------------
//   // 7) late: promise to assign the variable before it is used
//   // ---------------------------------------------------------
//   late String greeting;
//   greeting = 'Welcome to Lab $labNumber'; // assigned later, before use
//   print(greeting);
//
//   // ---------------------------------------------------------
//   // 8) Multi-line strings and escape characters
//   // ---------------------------------------------------------
//   String poem = '''
// Roses are red,
// Dart is cool,
// Flutter builds apps,
// And we are in school.''';
//   print(poem);
  print('Tab:\tseparated\nNew line above. Quote: \'single\'');
  print(r'Raw string: \n is NOT a new line here'); // r = raw string
}
