// =============================================================
// Session 4 | Part 1: Inheritance and abstract classes
// Run with:  dart run 01_inheritance_and_abstract.dart
// =============================================================
//
// INHERITANCE: a child class (subclass) gets the fields and methods of its
// parent class (superclass) and can add or change behaviour.
// Use it for an "is-a" relationship: a Dog IS an Animal.

void main() {
  // ---------------------------------------------------------
  // 1) A child object has everything from the parent AND its own members
  // ---------------------------------------------------------
  print('--- 1) Inheritance ---');
  Dog rex = Dog('Rex', 3, 'German Shepherd');
  rex.eat(); // inherited from Animal
  rex.fetch(); // defined only in Dog
  print('Name from the parent: ${rex.name}');

  // ---------------------------------------------------------
  // 2) Constructor order: the PARENT constructor runs first
  // ---------------------------------------------------------
  print('\n--- 2) Constructor order ---');
  Cat tom = Cat('Tom', 2);

  // ---------------------------------------------------------
  // 3) Overriding: the child replaces a method of the parent
  // ---------------------------------------------------------
  print('\n--- 3) Overriding ---');
  Animal generic = Animal('Creature', 1);
  generic.makeSound(); // parent version
  rex.makeSound(); // Dog version
  tom.makeSound(); // Cat version

  // ---------------------------------------------------------
  // 4) super.method(): reuse the parent version inside the override
  // ---------------------------------------------------------
  print('\n--- 4) super ---');
  print(generic.describe());
  print(rex.describe()); // uses super.describe() and adds the breed

  // ---------------------------------------------------------
  // 5) POLYMORPHISM: a parent-type variable can hold any child.
  //    Dart calls the version that belongs to the REAL object.
  // ---------------------------------------------------------
  print('\n--- 5) Polymorphism ---');
  List<Animal> animals = [rex, tom, Dog('Bella', 5, 'Poodle'), generic];
  for (Animal animal in animals) {
    animal.makeSound(); // different result for each real type
  }

  // ---------------------------------------------------------
  // 6) Type tests: `is` checks, `as` casts
  // ---------------------------------------------------------
  print('\n--- 6) is / as ---');
  for (Animal animal in animals) {
    if (animal is Dog) {
      // Inside this block Dart knows it is a Dog.
      animal.fetch();
    } else if (animal is Cat) {
      print('${animal.name} is a cat and ignores you.');
    }
    print('Runtime type: ${animal.runtimeType}');
  }
  Animal first = animals.first;
  Dog castDog = first as Dog; // crashes if `first` were not a Dog
  print('Cast worked: ${castDog.breed}');

  // ---------------------------------------------------------
  // 7) ABSTRACT classes: cannot be created, they define a contract
  // ---------------------------------------------------------
  print('\n--- 7) Abstract classes ---');
  // Beverage b = Beverage('x', 1); // ERROR: abstract classes can't be instantiated
  List<Beverage> menu = [
    Coffee('Latte', 50, shots: 2),
    Tea('Green Tea', 30),
    Coffee('Espresso', 35),
  ];
  for (Beverage drink in menu) {
    print(drink.prepare()); // each subclass provides its own steps
    print('  Price with tax: ${drink.priceWithTax.toStringAsFixed(2)}');
  }
  double total = menu.fold<double>(0, (sum, d) => sum + d.priceWithTax);
  print('Total of the menu: ${total.toStringAsFixed(2)}');

  // ---------------------------------------------------------
  // 8) Dart has no `protected`: the child can use any NON-private member
  //    of the parent, and a private `_member` is hidden outside its file.
  // ---------------------------------------------------------
}

// ===============================================================
// Parent class
// ===============================================================
class Animal {
  final String name;
  int age;

  Animal(this.name, this.age) {
    print('  Animal constructor ran for $name');
  }

  void eat() => print('$name is eating.');

  void makeSound() => print('$name makes a sound.');

  String describe() => '$name ($age years old)';
}

// ===============================================================
// Child classes
// ===============================================================
class Dog extends Animal {
  final String breed;

  // `: super(name, age)` sends the values up to the parent constructor.
  Dog(String name, int age, this.breed) : super(name, age) {
    print('  Dog constructor ran for $name');
  }

  void fetch() => print('$name fetches the ball!');

  @override
  void makeSound() => print('$name says: Woof!');

  @override
  String describe() => '${super.describe()} - a $breed';
}

class Cat extends Animal {
  // Super parameters (Dart 2.17+): shorter way to pass values to the parent.
  Cat(super.name, super.age) {
    print('  Cat constructor ran for $name');
  }

  @override
  void makeSound() => print('$name says: Meow!');
}

// ===============================================================
// Abstract class: some members have a body, some are abstract
// ===============================================================
abstract class Beverage {
  final String name;
  final double basePrice;

  Beverage(this.name, this.basePrice);

  // Abstract method: no body. Every subclass MUST implement it.
  String prepare();

  // Normal members are inherited as they are.
  double get taxRate => 0.14;

  double get priceWithTax => basePrice * (1 + taxRate);
}

class Coffee extends Beverage {
  final int shots;

  Coffee(super.name, super.basePrice, {this.shots = 1});

  @override
  String prepare() => 'Brew $name with $shots shot(s) of espresso.';

  // Overriding a getter
  @override
  double get priceWithTax => super.priceWithTax + (shots - 1) * 10;
}

class Tea extends Beverage {
  Tea(super.name, super.basePrice);

  @override
  String prepare() => 'Steep the tea bag for 3 minutes for $name.';
}
