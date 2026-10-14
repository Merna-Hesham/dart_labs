// =============================================================
// Session 3 | Part 3: Encapsulation, getters and setters
// Run with:  dart run 03_encapsulation.dart
// (it imports 03_encapsulation_speaker.dart, keep both files together)
// =============================================================
//
// Encapsulation = keep the data PRIVATE and give controlled access to it,
// so an object can never get into an invalid state.

import '03_encapsulation_speaker.dart';

void main() {
  // ---------------------------------------------------------
  // 1) Using a class that hides its data (see the Speaker file)
  // ---------------------------------------------------------
  Speaker speaker = Speaker(); // volume 30
  print(speaker);

  // ---------------------------------------------------------
  // 2) The setter validates before it changes anything
  // ---------------------------------------------------------
  speaker.volume = 60; // looks like a field, but runs the setter code
  print('After setting 60: $speaker');

  try {
    speaker.volume = 150; // invalid -> the setter throws
  } on ArgumentError catch (e) {
    print('Rejected: ${e.message}');
  }
  print('Still valid after the error: $speaker');

  // ---------------------------------------------------------
  // 3) Private members are NOT accessible from another file
  // ---------------------------------------------------------
  // print(speaker._volume); // ERROR: '_volume' isn't defined for Speaker
  // speaker._validate(10);  // ERROR: same reason
  // speaker.level = 'loud'; // ERROR: `level` has a getter but NO setter

  // ---------------------------------------------------------
  // 4) Methods and computed getters
  // ---------------------------------------------------------
  speaker.mute();
  print('Muted: volume=${speaker.volume}, level=${speaker.level}');
  speaker.unmute();
  speaker.louder(50); // 60 + 50 would be 110, so it stops at 100
  print('After louder(50): $speaker');

  // ---------------------------------------------------------
  // 5) Protecting a collection: the history getter is read-only
  // ---------------------------------------------------------
  print('History of volumes: ${speaker.history}');
  try {
    speaker.history.add(999); // the returned list is unmodifiable
  } on UnsupportedError {
    print('Cannot edit the history from outside the class.');
  }

  // ---------------------------------------------------------
  // 6) Privacy is per FILE, not per class
  //    Inside the SAME file, other code can still reach `_secret`.
  //    That is why we put Speaker in its own file for this demo.
  // ---------------------------------------------------------
  Diary diary = Diary('My secret');
  print('Same file can see _secret: ${diary._secret}'); // allowed here
}

class Diary {
  String _secret;
  Diary(this._secret);
}
