// =============================================================
// Session 3 | Part 4: static members, toString, equality
// Run with:  dart run 04_static_tostring_equality.dart
// =============================================================

void main() {
  // ---------------------------------------------------------
  // 1) toString(): what you see when you print an object
  // ---------------------------------------------------------
  print('--- 1) toString ---');
  Plain plain = Plain(5);
  print(plain); // Instance of 'Plain'  (not helpful)

  Coordinate c = Coordinate(3, 4);
  print(c); // Coordinate(3, 4)       (our own toString)

  // ---------------------------------------------------------
  // 2) static fields: ONE value shared by the whole class
  // ---------------------------------------------------------
  print('\n--- 2) static fields ---');
  print('Tickets created so far: ${Ticket.totalCreated}'); // 0
  Ticket t1 = Ticket();
  Ticket t2 = Ticket();
  Ticket t3 = Ticket();
  print('Ticket numbers: ${t1.number}, ${t2.number}, ${t3.number}');
  print('Tickets created now: ${Ticket.totalCreated}'); // 3
  // Call static members on the CLASS, not on an object:
  // print(t1.totalCreated); // ERROR

  // ---------------------------------------------------------
  // 3) static methods and constants: utilities without objects
  // ---------------------------------------------------------
  print('\n--- 3) static methods ---');
  print('isEven(10)      = ${MathUtils.isEven(10)}');
  print('factorial(5)    = ${MathUtils.factorial(5)}');
  print('average         = ${MathUtils.average([4, 8, 15, 16, 23, 42])}');
  print('MathUtils.pi    = ${MathUtils.pi}');
  print('Origin constant = ${Coordinate.origin}');

  // ---------------------------------------------------------
  // 4) Equality: == compares REFERENCES by default
  // ---------------------------------------------------------
  print('\n--- 4) Equality ---');
  Plain p1 = Plain(1);
  Plain p2 = Plain(1);
  Plain p3 = p1;
  print('Plain(1) == Plain(1)      : ${p1 == p2}'); // false (different objects)
  print('identical(p1, p2)           : ${identical(p1, p2)}'); // still false
  print('Plain(1) == Plain(3)      : ${p1 == p3}'); // true (same objects)
  print('identical(p1, p3)           : ${identical(p1, p3)}'); // true (same objects)

  // Coordinate overrides == and hashCode to compare VALUES
  Coordinate a = Coordinate(1, 2);
  Coordinate b = Coordinate(1, 2);
  Coordinate d = Coordinate(5, 6);
  print('Coordinate(1,2) == (1,2)  : ${a == b}'); // true
  print('Coordinate(1,2) == (5,6)  : ${a == d}'); // false
  print('identical(a, b)           : ${identical(a, b)}'); // still false

  // ---------------------------------------------------------
  // 5) Why hashCode matters: Sets and Map keys use it
  // ---------------------------------------------------------
  print('\n--- 5) hashCode in a Set ---');
  Set<Plain> plains = {Plain(1), Plain(1), Plain(1)};
  Set<Coordinate> coordinates = {Coordinate(1, 2), Coordinate(1, 2), a};
  print('Set of Plain without ==/hashCode : ${plains.length} items'); // 3
  print('Set of Coordinate with them      : ${coordinates.length} item'); // 1

  // ---------------------------------------------------------
  // 6) Operator overloading: give + and - a meaning for your class
  // ---------------------------------------------------------
  print('\n--- 6) Operators ---');
  Coordinate sum = a + d;
  Coordinate diff = d - a;
  print('$a + $d = $sum');
  print('$d - $a = $diff');
}

/// A class WITHOUT toString, ==, hashCode.
class Plain {
  final int id;
  Plain(this.id);
}

/// Value object: two coordinates with the same x and y are "equal".
class Coordinate {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  // A static constant: shared by the class, needs no object.
  static const Coordinate origin = Coordinate(0, 0);

  @override
  String toString() => 'Coordinate($x, $y)';

  // Rule: whenever you override ==, also override hashCode.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // same object -> equal
    return other is Coordinate && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y); // combines the fields

  // Operator overloading
  Coordinate operator +(Coordinate other) =>
      Coordinate(x + other.x, y + other.y);
  Coordinate operator -(Coordinate other) =>
      Coordinate(x - other.x, y - other.y);
}

/// static counter: every new Ticket increases it.
class Ticket {
  static int _count = 0; // private static: only this class changes it
  static int get totalCreated => _count; // public read-only access

  final int number;

  // `++_count` increases the counter, then uses the new value.
  Ticket() : number = ++_count;
}

/// A class that only groups helper functions (never instantiated).
class MathUtils {
  MathUtils._(); // private constructor: nobody can create an object

  static const double pi = 3.14159;

  static bool isEven(int n) => n % 2 == 0;

  static int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }

  static double average(List<num> numbers) {
    if (numbers.isEmpty) return 0;
    return numbers.fold<num>(0, (sum, n) => sum + n) / numbers.length;
  }
}
