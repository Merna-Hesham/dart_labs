// =============================================================
// Session 3 | Part 2: Constructors
// Run with:  dart run 02_constructors.dart
// =============================================================
//
// A constructor is a special method that builds an object.
// It has the SAME NAME as the class and no return type.

void main() {
  // ---------------------------------------------------------
  // 1) Default constructor: if you write none, Dart gives you one
  // ---------------------------------------------------------
  print('--- 1) Default constructor ---');
  Empty e = Empty();
  print('Empty.value = ${e.value}');

  // ---------------------------------------------------------
  // 2) Generative constructor with `this.field` shortcuts
  //    and an optional positional parameter with a default
  // ---------------------------------------------------------
  print('\n--- 2) Parameterized constructor ---');
  Phone p1 = Phone('Samsung', 'S24');
  Phone p2 = Phone('Apple', 'iPhone 15', 256);
  print(p1);
  print(p2);

  // ---------------------------------------------------------
  // 3) Named parameters in a constructor ({ })
  // ---------------------------------------------------------
  print('\n--- 3) Named parameters ---');
  Laptop l1 = Laptop(brand: 'Dell', ram: 16);
  Laptop l2 = Laptop(ram: 32, brand: 'Lenovo', hasTouch: true); // any order
  print(l1);
  print(l2);

  // ---------------------------------------------------------
  // 4) Named constructors: several ways to build the same class
  // ---------------------------------------------------------
  print('\n--- 4) Named constructors ---');
  User u1 = User('sara', 'sara@mail.com');
  User guest = User.guest();
  User fromMap = User.fromMap({'name': 'omar', 'email': 'omar@mail.com'});
  User partial = User.fromMap({'name': 'nour'}); // missing email
  print(u1);
  print(guest);
  print(fromMap);
  print(partial);

  // ---------------------------------------------------------
  // 5) Initializer list: runs BEFORE the constructor body
  //    It can set final fields and run an `assert`.
  // ---------------------------------------------------------
  print('\n--- 5) Initializer list ---');
  Circle c = Circle(5);
  print('Radius ${c.radius}, area ${c.area.toStringAsFixed(2)}');
  // Circle(-1); // would stop the program: assertion failed (debug mode)

  // ---------------------------------------------------------
  // 6) Redirecting constructors: one constructor calls another
  // ---------------------------------------------------------
  print('\n--- 6) Redirecting constructors ---');
  Color custom = Color(10, 20, 30);
  Color red = Color.red();
  Color black = Color.black();
  print('$custom | $red | $black');

  // ---------------------------------------------------------
  // 7) const constructors: compile-time constant objects
  //    Two identical const objects are the SAME object in memory.
  // ---------------------------------------------------------
  print('\n--- 7) const constructor ---');
  const Point a = Point(1, 2);
  const Point b = Point(1, 2);
  Point d = Point(1, 2); // not const: a brand new object
  print('a and b identical? ${identical(a, b)}'); // true
  print('a and d identical? ${identical(a, d)}'); // false

  // ---------------------------------------------------------
  // 8) factory constructors: may return an existing object
  // ---------------------------------------------------------
  print('\n--- 8) factory: singleton ---');
  Logger log1 = Logger();
  Logger log2 = Logger();
  log1.log('Hello from log1');
  print('log1 and log2 identical? ${identical(log1, log2)}'); // true

  print('\n--- 8) factory: cache ---');
  Currency usd1 = Currency('usd');
  Currency usd2 = Currency('USD');
  Currency egp = Currency('EGP');
  print('usd1 and usd2 identical? ${identical(usd1, usd2)}'); // true
  print('Currencies created: ${Currency.createdCount}'); // 2
  print(egp);
}

// -------------------------------------------------------------
// 1) Default constructor (none written)
// -------------------------------------------------------------
class Empty {
  int value = 7; // fields can have a default value
}

// -------------------------------------------------------------
// 2) Positional constructor with an optional parameter
// -------------------------------------------------------------
class Phone {
  String brand;
  String model;
  int storageGb;

  Phone(this.brand, this.model, [this.storageGb = 128]);

  @override
  String toString() => 'Phone($brand $model, ${storageGb}GB)';
}

// -------------------------------------------------------------
// 3) Named parameters: `required` forces the caller to pass them
// -------------------------------------------------------------
class Laptop {
  final String brand;
  final int ram;
  final bool hasTouch;

  Laptop({required this.brand, required this.ram, this.hasTouch = false});

  @override
  String toString() => 'Laptop($brand, ${ram}GB RAM, touch: $hasTouch)';
}

// -------------------------------------------------------------
// 4) Named constructors + 5) initializer lists
// -------------------------------------------------------------
class User {
  String name;
  String email;
  bool isGuest;

  // Main constructor: the part after `:` is the initializer list.
  User(this.name, this.email) : isGuest = false;

  // Named constructor: ClassName.name(...)
  User.guest()
      : name = 'Guest',
        email = 'none',
        isGuest = true;

  // Named constructor that builds a User from a Map (like JSON data).
  User.fromMap(Map<String, String> data)
      : name = data['name'] ?? 'Unknown',
        email = data['email'] ?? 'none',
        isGuest = false;

  @override
  String toString() => 'User($name, $email, guest: $isGuest)';
}

// -------------------------------------------------------------
// 5) Initializer list with assert and a computed final field
// -------------------------------------------------------------
class Circle {
  final double radius;
  final double area;

  Circle(double r)
      : assert(r > 0, 'Radius must be positive'),
        radius = r,
        area = 3.14159 * r * r;
}

// -------------------------------------------------------------
// 6) Redirecting constructors use `: this(...)`
// -------------------------------------------------------------
class Color {
  final int r;
  final int g;
  final int b;

  Color(this.r, this.g, this.b);
  Color.red() : this(255, 0, 0); // redirects to the main constructor
  Color.black() : this(0, 0, 0);

  @override
  String toString() => 'Color($r, $g, $b)';
}

// -------------------------------------------------------------
// 7) const constructor: all fields must be final
// -------------------------------------------------------------
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);
}

// -------------------------------------------------------------
// 8) factory constructors
// -------------------------------------------------------------

/// Singleton: only one Logger object ever exists.
class Logger {
  static final Logger _instance = Logger._internal();

  // `factory` does not have to create a new object: it returns the same one.
  factory Logger() => _instance;

  // Private named constructor: nobody outside can call it.
  Logger._internal();

  void log(String message) => print('[LOG] $message');
}

/// Cache: ask for the same code twice, get the same object.
class Currency {
  static final Map<String, Currency> _cache = {};
  static int createdCount = 0;

  final String code;

  Currency._(this.code) {
    createdCount++;
  }

  factory Currency(String code) {
    String key = code.toUpperCase();
    // putIfAbsent only builds a new Currency when the key is missing.
    return _cache.putIfAbsent(key, () => Currency._(key));
  }

  @override
  String toString() => 'Currency($code)';
}
