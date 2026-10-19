// =============================================================
// Session 4 | Guided Lab: Shape hierarchy with a Printable mixin
// Skills practiced: abstract class, inheritance, super, polymorphism,
//   mixin, getters, sorting and fold on a list of objects
// Run with:  dart run 05_guided_lab_shapes.dart
//
// How to run this lab in class (build the classes at the bottom in order):
//   STEP 1  mixin Printable
//   STEP 2  abstract class Shape (name, area, perimeter)
//   STEP 3  Circle and Rectangle
//   STEP 4  Square extends Rectangle (reuse!)
//   STEP 5  Triangle
//   STEP 6  use them all through a List<Shape>
// =============================================================

// `show` imports only what we need. (dart:math also contains a class named
// Rectangle, and importing everything could confuse our own Rectangle.)
import 'dart:math' show pi, sqrt;

void main() {
  // STEP 6: one list, many kinds of shapes (polymorphism)
  List<Shape> shapes = [
    Circle(5),
    Rectangle(4, 6),
    Square(3),
    Triangle(3, 4, 5),
    Circle(1.5),
    Rectangle(10, 2),
  ];

  print('===== All shapes =====');
  for (Shape shape in shapes) {
    shape.printInfo(); // from the Printable mixin
  }

  // Sort by area, biggest first (copy first, keep the original order)
  print('\n===== Sorted by area (largest first) =====');
  List<Shape> sorted = [...shapes]..sort((a, b) => b.area.compareTo(a.area));
  for (Shape shape in sorted) {
    print('${shape.name.padRight(10)} ${shape.area.toStringAsFixed(2)}');
  }

  // Totals with fold
  double totalArea = shapes.fold<double>(0, (sum, s) => sum + s.area);
  double totalPerimeter = shapes.fold<double>(0, (sum, s) => sum + s.perimeter);
  print('\nTotal area      : ${totalArea.toStringAsFixed(2)}');
  print('Total perimeter : ${totalPerimeter.toStringAsFixed(2)}');

  // Biggest shape with reduce
  Shape biggest = shapes.reduce((a, b) => a.area >= b.area ? a : b);
  print('Biggest shape   : ${biggest.name} (${biggest.area.toStringAsFixed(2)})');

  // Type tests
  print('\n===== Type tests =====');
  int rectangles = shapes.whereType<Rectangle>().length; // includes Square!
  int squares = shapes.whereType<Square>().length;
  print('Rectangles (a Square IS a Rectangle): $rectangles');
  print('Squares                             : $squares');

  for (Shape shape in shapes) {
    if (shape is Square) {
      print('A square with side ${shape.side} has diagonal '
          '${shape.diagonal.toStringAsFixed(2)}');
    }
  }

  // Abstract classes cannot be created:
  // Shape s = Shape('x'); // ERROR
}

// ===============================================================
// STEP 1: the mixin. Any class that provides `label` can print itself.
// ===============================================================
mixin Printable {
  String get label; // the class that uses the mixin must provide this

  void printInfo() => print(label);
}

// ===============================================================
// STEP 2: the abstract parent
// ===============================================================
abstract class Shape with Printable {
  final String name;

  Shape(this.name);

  // Every shape MUST know how to compute these two.
  double get area;
  double get perimeter;

  // Satisfies the mixin's requirement, using the abstract getters above.
  @override
  String get label => '${name.padRight(10)} area: '
      '${area.toStringAsFixed(2).padLeft(8)}  perimeter: '
      '${perimeter.toStringAsFixed(2).padLeft(8)}';
}

// ===============================================================
// STEP 3: concrete shapes
// ===============================================================
class Circle extends Shape {
  final double radius;

  Circle(this.radius) : super('Circle');

  @override
  double get area => pi * radius * radius;

  @override
  double get perimeter => 2 * pi * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  // Optional third parameter lets a subclass choose its own name.
  Rectangle(this.width, this.height, [String name = 'Rectangle']) : super(name);

  @override
  double get area => width * height;

  @override
  double get perimeter => 2 * (width + height);
}

// ===============================================================
// STEP 4: a Square is a Rectangle with equal sides (reuse by inheritance)
// ===============================================================
class Square extends Rectangle {
  Square(double side) : super(side, side, 'Square');

  double get side => width;

  // A member that only squares have
  double get diagonal => side * sqrt(2);
}

// ===============================================================
// STEP 5: triangle from three sides (Heron's formula)
// ===============================================================
class Triangle extends Shape {
  final double a;
  final double b;
  final double c;

  Triangle(this.a, this.b, this.c) : super('Triangle') {
    // A triangle is only possible when each side is shorter than the sum
    // of the other two.
    if (a + b <= c || a + c <= b || b + c <= a) {
      throw ArgumentError('Sides $a, $b, $c cannot form a triangle');
    }
  }

  @override
  double get area {
    double s = perimeter / 2; // semi-perimeter
    return sqrt(s * (s - a) * (s - b) * (s - c));
  }

  @override
  double get perimeter => a + b + c;
}
