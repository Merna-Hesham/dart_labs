// =============================================================
// Session 3 | Part 1: Classes and objects
// Run with:  dart run 01_classes_and_objects.dart
// =============================================================
//
// A CLASS is a blueprint. An OBJECT is one thing built from it.
// A class groups:
//   - fields   (the data an object remembers)
//   - methods  (what an object can do)

void main() {
  // ---------------------------------------------------------
  // 1) Create objects (instances) from the class
  //    `new` is not needed in Dart.
  // ---------------------------------------------------------
  Person ali = Person('Ali', 20);
  Person mona = Person('Mona', 25);

  // ---------------------------------------------------------
  // 2) Call methods and read fields with the dot (.)
  // ---------------------------------------------------------
  ali.introduce();
  mona.introduce();

  // ---------------------------------------------------------
  // 3) Change a field directly
  // ---------------------------------------------------------
  ali.age = 21;
  print('Ali is now ${ali.age}');

  // ---------------------------------------------------------
  // 4) Objects are INDEPENDENT: each has its own copy of the fields
  // ---------------------------------------------------------
  ali.birthday(); // only Ali changes
  print('Ali: ${ali.age}, Mona: ${mona.age}');

  // ---------------------------------------------------------
  // 5) Nullable fields and getters
  // ---------------------------------------------------------
  print('Display name before nickname: ${ali.displayName}');
  ali.nickname = 'Lolo';
  print('Display name after nickname : ${ali.displayName}');

  // `final` field: it is set once and can never change
  print('Species: ${ali.species}');
  // ali.species = 'robot'; // ERROR: species is final

  // ---------------------------------------------------------
  // 6) Methods that take another object as a parameter
  // ---------------------------------------------------------
  print('Is Ali older than Mona? ${ali.isOlderThan(mona)}');

  // ---------------------------------------------------------
  // 7) Objects are stored by REFERENCE
  //    `alias` points to the SAME object, it is not a copy.
  // ---------------------------------------------------------
  Person alias = ali;
  alias.name = 'Ali (renamed through alias)';
  print('ali.name = ${ali.name}'); // changed too!
  print('Same object? ${identical(ali, alias)}'); // true

  Person lookAlike = Person(ali.name, ali.age);
  print('Same object as a look-alike? ${identical(ali, lookAlike)}'); // false

  // ---------------------------------------------------------
  // 8) Passing an object to a function: the function changes the original
  // ---------------------------------------------------------
  Person sara = Person('Sara', 19);
  celebrate(sara);
  print('Sara after celebrate(): ${sara.age}');

  // ---------------------------------------------------------
  // 9) A list of objects
  // ---------------------------------------------------------
  List<Person> team = [ali, mona, sara, Person('Omar', 30)];
  print('--- Team ---');
  for (Person p in team) {
    p.introduce();
  }
  List<String> adults =
      team.where((p) => p.isAdult).map((p) => p.name).toList();
  print('Adults: $adults');

  // ---------------------------------------------------------
  // 10) Cascade operator (..): call several things on the same object
  // ---------------------------------------------------------
  Person nour = Person('Nour', 17)
    ..nickname = 'Nono'
    ..birthday()
    ..introduce();
  print('Nour is adult now? ${nour.isAdult}');

  // ---------------------------------------------------------
  // 11) Method chaining: methods that `return this`
  // ---------------------------------------------------------
  Person hany = Person('Hany', 30);
  hany.birthday().birthday().birthday();
  print('Hany after 3 birthdays: ${hany.age}');
}

/// A function that receives an object and changes it.
void celebrate(Person person) {
  person.birthday();
}

/// Our first class. The name starts with a capital letter (UpperCamelCase).
class Person {
  // ----- Fields (instance variables) -----
  String name;
  int age;
  String? nickname; // may be null, so it needs `?`
  final String species = 'human'; // final: assigned once, here

  // ----- Constructor (full explanation in Part 2) -----
  // `this.name` copies the argument straight into the field.
  Person(this.name, this.age);

  // ----- Methods -----
  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }

  /// Returns `this` so calls can be chained: p.birthday().birthday()
  Person birthday() {
    age++;
    return this;
  }

  /// Here the parameter `age` has the same name as the field.
  /// `this.age` means the field, plain `age` means the parameter.
  void setAge(int age) {
    this.age = age;
  }

  /// Compare this object with another one.
  bool isOlderThan(Person other) {
    return age > other.age; // same as this.age > other.age
  }

  // ----- Getters: computed values that look like fields -----
  bool get isAdult => age >= 18;
  String get displayName => nickname ?? name;
}
