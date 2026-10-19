// =============================================================
// Session 4 | Part 2: Interfaces and polymorphism
// Run with:  dart run 02_interfaces_and_polymorphism.dart
// =============================================================
//
// INTERFACE: a contract that says WHAT a class can do, not HOW.
// In Dart every class defines an interface. With `implements` a class
// promises to provide ALL members of that interface, and it inherits
// NO code from it (unlike `extends`).

void main() {
  // ---------------------------------------------------------
  // 1) Different classes, one contract
  // ---------------------------------------------------------
  print('--- 1) Implementing an interface ---');
  Song song = Song('Shape of You', 'Ed Sheeran');
  Video video = Video('Dart in 100 seconds', 100);
  Podcast podcast = Podcast('Flutter Weekly', 42);

  song.play();
  video.play();
  podcast.play();

  // ---------------------------------------------------------
  // 2) Program to the INTERFACE: one function works with any Playable
  // ---------------------------------------------------------
  print('\n--- 2) Polymorphism with a list ---');
  List<Playable> queue = [song, video, podcast];
  playAll(queue);

  // ---------------------------------------------------------
  // 3) A class can implement SEVERAL interfaces
  // ---------------------------------------------------------
  print('\n--- 3) Several interfaces ---');
  podcast.download(); // Podcast is Playable AND Downloadable
  song.download();

  // ---------------------------------------------------------
  // 4) Implementing a CONCRETE class: its public members become the contract
  //    Very useful to create "fake" versions for testing.
  // ---------------------------------------------------------
  print('\n--- 4) Fake object for testing ---');
  Printer real = Printer();
  Printer fake = FakePrinter();
  sendReport(real, 'Monthly report');
  sendReport(fake, 'Monthly report');

  // ---------------------------------------------------------
  // 5) Dynamic dispatch: the real object decides which code runs
  // ---------------------------------------------------------
  print('\n--- 5) Which version runs? ---');
  Playable mystery = DateTime.now().second.isEven ? song : video;
  mystery.play(); // decided at run time, not when you wrote the code

  // ---------------------------------------------------------
  // 6) extends vs implements vs with (summary)
  // ---------------------------------------------------------
  print('\n--- 6) Summary ---');
  print('extends    : inherit code, ONE parent only');
  print('implements : promise the members, no code inherited, MANY allowed');
  print('with       : add reusable code from a mixin, MANY allowed (Part 3)');
}

// ===============================================================
// Interfaces (abstract classes with only method signatures)
// ===============================================================
abstract class Playable {
  String get title;
  void play();
  void pause();
}

abstract class Downloadable {
  void download();
}

// Dart 3 also has the modifier `interface`:
//   abstract interface class Playable { ... }
// It forbids `extends` outside the file, so the class can only be implemented.

// ===============================================================
// Implementations
// ===============================================================
class Song implements Playable, Downloadable {
  final String artist;

  // The getter `title` must exist; a final field satisfies it.
  @override
  final String title;

  Song(this.title, this.artist);

  @override
  void play() => print('Playing song "$title" by $artist');

  @override
  void pause() => print('Song paused');

  @override
  void download() => print('Downloading song "$title" (5 MB)');
}

class Video implements Playable {
  @override
  final String title;
  final int seconds;

  Video(this.title, this.seconds);

  @override
  void play() => print('Playing video "$title" (${seconds}s)');

  @override
  void pause() => print('Video paused');
}

class Podcast implements Playable, Downloadable {
  @override
  final String title;
  final int minutes;

  Podcast(this.title, this.minutes);

  @override
  void play() => print('Playing podcast "$title" ($minutes min)');

  @override
  void pause() => print('Podcast paused');

  @override
  void download() => print('Downloading podcast "$title" (40 MB)');
}

/// Works with ANY Playable, present or future.
void playAll(List<Playable> items) {
  for (Playable item in items) {
    item.play();
  }
}

// ===============================================================
// Implementing a concrete class
// ===============================================================
class Printer {
  void printDocument(String text) => print('Printing on paper: $text');
}

class FakePrinter implements Printer {
  @override
  void printDocument(String text) => print('(fake) pretending to print: $text');
}

void sendReport(Printer printer, String text) => printer.printDocument(text);
