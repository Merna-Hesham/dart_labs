// =============================================================
// Session 1 | Part 2: Built-in types and null safety
// Run with:  dart run 02_types_and_null_safety.dart
// =============================================================

void main() {
  // ---------------------------------------------------------
  // 1) Numbers: int (whole) and double (decimal)
  // ---------------------------------------------------------
  // int apples = 5;
  // double price = 2.5;
  // num total = apples * price; // `num` can hold either int or double
  // print('Total price: $total');

  // // Converting between number types
  // int rounded = price.round(); // 2.5 -> 3
  // double asDouble = apples.toDouble(); // 5 -> 5.0
  // print('Rounded: $rounded | As double: $asDouble');

  // // ---------------------------------------------------------
  // // 2) String <-> number conversion
  // // ---------------------------------------------------------
  // int parsed = int.parse('42'); // throws an error if not a number
  // int? safeParsed = int.tryParse('abc'); // returns null instead of crashing
  // print('Parsed: $parsed | Safe parse of "abc": $safeParsed');
  //
  // String asText = 123.toString();
  // String twoDecimals = 3.14159.toStringAsFixed(2); // "3.14"
  // print('As text: $asText | Two decimals: $twoDecimals');

  // // ---------------------------------------------------------
  // // 3) Useful String members
  // // ---------------------------------------------------------
  // String text = '  Hello Flutter  ';
  // print('Length: ${text.length}');
  // print('Trim: "${text.trim()}"');
  // print('Upper: ${text.toUpperCase()}');
  // print('Contains "Flutter": ${text.contains('Flutter')}');
  // print('Replace: ${text.replaceAll('Flutter', 'Dart')}');
  // print('Substring: ${text.trim().substring(0, 5)}');

  // // ---------------------------------------------------------
  // // 4) NULL SAFETY
  // //    By default a variable can NEVER be null.
  // //    Add `?` to the type to allow null.
  // // ---------------------------------------------------------
  String firstName = 'Sara'; // cannot be null
  // firstName = null; // ERROR: null is not allowed here

  // String? nickname; // the ? means "may be null"; default value is null
  // print('Nickname right now: $nickname');
  // nickname = 'Sasa';
  // print('Nickname after assignment: $nickname');
  //
  // // ---------------------------------------------------------
  // // 5) Null-aware operators
  // // ---------------------------------------------------------
  String? middleName; // null

  // `??` -> use a default value when the left side is null
  String displayName = middleName ?? 'No middle name';
  print('?? result: $displayName');

  // `?.` -> call a member ONLY if the object is not null
  print('?. result: ${middleName?.length}'); // prints null, no crash

  // `??=` -> assign only if the variable is currently null
  middleName ??= 'Mohamed';
  print('??= result: $middleName');

  // `!` -> "I promise it is not null" (crashes if you are wrong!)
  String sure = middleName!;
  print('! result: $sure');

  // // ---------------------------------------------------------
  // // 6) Null check with if (type promotion)
  // // ---------------------------------------------------------
  String? maybeCity = 'Cairo';
  if (maybeCity != null) {
    // Inside this block Dart KNOWS maybeCity is not null.
    print('City length: ${maybeCity.length}');
  }
  //
  // // ---------------------------------------------------------
  // // 7) The `dynamic` and `Object` types (use sparingly)
  // // ---------------------------------------------------------
  dynamic anything = 10;
  anything = 'now I am a String'; // allowed, but unsafe: no type checks
  anything = 3.14;
  print('dynamic holds: $anything (${anything.runtimeType})');

  // Check a type at runtime with `is`
  Object value = 3.5;
  if (value is double) {
    print('$value is a double');
  }
  // value = 'Hello';
  // print('$value, its type: ${value.runtimeType}');
}
