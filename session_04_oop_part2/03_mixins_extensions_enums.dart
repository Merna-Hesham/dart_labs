// =============================================================
// Session 4 | Part 3: Mixins, extension methods, enhanced enums
// Run with:  dart run 03_mixins_extensions_enums.dart
// =============================================================

void main() {
  mixinsDemo();
  extensionsDemo();
  enumsDemo();
}

// ===============================================================
// PART 1: MIXINS
// A mixin is a bundle of fields and methods you can add to MANY classes,
// even when they do not share a parent. Use it for "can-do" abilities.
// ===============================================================
mixin Swimmer {
  void swim() => print('$runtimeType is swimming.');
}

mixin Flyer {
  int altitude = 0; // mixins may hold state

  void fly() {
    altitude = 100;
    print('$runtimeType is flying at $altitude m.');
  }
}

class Fish with Swimmer {}

class Eagle with Flyer {}

class Duck with Swimmer, Flyer {
  // Duck gets swim() and fly() without copying any code.
}

// `on` restricts a mixin: only classes that extend Base can use it.
class Base {
  String get name => 'base object';
}

mixin Greeter on Base {
  void greet() => print('Hello from $name'); // can use members of Base
}

class Guest extends Base with Greeter {}

void mixinsDemo() {
  print('===== MIXINS =====');
  Fish fish = Fish();
  Duck duck = Duck();
  Eagle eagle = Eagle();

  fish.swim();
  eagle.fly();
  duck.swim();
  duck.fly();

  // A mixin also defines a type, so `is` works.
  print('duck is Swimmer? ${duck is Swimmer}'); // true
  print('eagle is Swimmer? ${eagle is Swimmer}'); // false

  // Treat different classes through the same ability
  List<Swimmer> swimmers = [fish, duck];
  for (Swimmer s in swimmers) {
    s.swim();
  }

  Guest().greet();
}

// ===============================================================
// PART 2: EXTENSION METHODS
// Add new methods to an EXISTING type (even String or int)
// without changing or inheriting from it.
// ===============================================================
extension StringExtras on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  bool get isPalindrome {
    String cleaned = toLowerCase().replaceAll(' ', '');
    return cleaned == cleaned.split('').reversed.join();
  }

  int get wordCount =>
      trim().isEmpty ? 0 : trim().split(RegExp(r'\s+')).length;
}

extension IntExtras on int {
  bool get isPrime {
    if (this < 2) return false;
    for (int i = 2; i * i <= this; i++) {
      if (this % i == 0) return false;
    }
    return true;
  }

  int get factorial => this <= 1 ? 1 : this * (this - 1).factorial;

  Duration get seconds => Duration(seconds: this);
}

extension NumberListExtras on List<int> {
  int get sum => fold(0, (a, b) => a + b);
  double get average => isEmpty ? 0 : sum / length;
}

void extensionsDemo() {
  print('\n===== EXTENSIONS =====');

  print('"hELLO".capitalize()        = ${'hELLO'.capitalize()}');
  print('"Never odd or even" palind. = ${'Never odd or even'.isPalindrome}');
  print('"Dart is really fun" words  = ${'Dart is really fun'.wordCount}');

  print('7.isPrime                   = ${7.isPrime}');
  print('10.isPrime                  = ${10.isPrime}');
  print('5.factorial                 = ${5.factorial}');
  print('90.seconds                  = ${90.seconds}');

  List<int> marks = [70, 85, 90, 65];
  print('sum = ${marks.sum}, average = ${marks.average}');
}

// ===============================================================
// PART 3: ENHANCED ENUMS
// An enum is a fixed set of named values. In Dart 2.17+ an enum can
// have fields, constructors, getters and methods.
// ===============================================================

// Simple enum
enum Direction { north, east, south, west }

// Enhanced enum
enum Priority {
  low('Low', 1),
  medium('Medium', 2),
  high('High', 3);

  // Constructor must be const; the fields must be final.
  const Priority(this.label, this.weight);

  final String label;
  final int weight;

  bool get isUrgent => this == Priority.high;

  // A method that uses a switch EXPRESSION over the enum.
  // Dart checks that you covered every value.
  Priority get escalated => switch (this) {
        Priority.low => Priority.medium,
        Priority.medium => Priority.high,
        Priority.high => Priority.high,
      };
}

void enumsDemo() {
  print('\n===== ENUMS =====');

  // Basics
  Direction d = Direction.south;
  print('d = $d, name = ${d.name}, index = ${d.index}');
  print('All directions: ${Direction.values}');

  // Looping over every value
  for (Priority p in Priority.values) {
    print('${p.name}: label=${p.label}, weight=${p.weight}, '
        'urgent=${p.isUrgent}');
  }

  // Comparing and converting
  Priority chosen = Priority.values.byName('medium'); // from a String
  print('byName("medium") -> $chosen');
  print('escalated: ${chosen.escalated} -> ${chosen.escalated.escalated}');

  // switch statement with an enum (no default needed when all are covered)
  switch (chosen) {
    case Priority.low:
      print('Handle whenever.');
    case Priority.medium:
      print('Handle this week.'); // Dart 3: no `break` needed
    case Priority.high:
      print('Handle now!');
  }

  // Sorting by an enum field
  List<Priority> tasks = [Priority.high, Priority.low, Priority.medium];
  tasks.sort((a, b) => a.weight.compareTo(b.weight));
  print('Sorted by weight: ${tasks.map((p) => p.label).toList()}');
}
