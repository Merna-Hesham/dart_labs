// =====================================================================
// SESSION 4 | LAB TASK: Mini E-commerce
// Run with:  dart run 06_lab_task_mini_ecommerce.dart
// =====================================================================
//
// ------------------------- TASK DESCRIPTION --------------------------
//
// Model a tiny online shop. Everything is printed from `main`.
//
// 1) abstract class Product
//      - final fields: id, name, price (price must not be negative)
//      - abstract getters: taxRate (double) and category (String)
//      - concrete getter priceWithTax = price x (1 + taxRate)
//      - toString(), and == / hashCode based on the id
//    Subclasses:
//      - Book         taxRate 0%,  extra field `author`
//      - Electronics  taxRate 14%, extra field `warrantyMonths`
//      - Clothing     taxRate 10%, extra field `size`
//
// 2) interface Discountable   (double get discountPercent)
//      - implemented by Electronics (10%) and Clothing (20%), NOT by Book
//
// 3) mixin Loggable           (void log(String message) prints "[ClassName] message")
//      - used by Cart and Order
//
// 4) generic class Cart<T extends Product> with Loggable
//      - add(T product, [int quantity = 1])  -> quantity must be > 0
//      - remove(T product)
//      - total: the sum of unitPrice x quantity, where unitPrice is
//        priceWithTax minus the discount when the product is Discountable
//      - an unmodifiable view `lines`, plus isEmpty and printCart()
//
// 5) enum OrderStatus { pending, paid, shipped, delivered, cancelled }
//      - fields: label
//      - getter `next` (null at the end) and getter `canCancel`
//        (only pending or paid orders can be cancelled)
//
// 6) class Order with Loggable
//      - static id generator
//      - created from a Cart<Product> (copies the lines and the total)
//      - advance() moves to the next status, cancel() cancels when allowed
//        (throw a StateError when the action is not allowed)
//
// 7) extension on double:  String get egp => '12.50 EGP'
//
// In `main`: create two products of each kind, fill a Cart<Product>,
// print it, create an Order, move it through every status, and try to
// cancel it once when it is allowed and once when it is not.
// Also create a Cart<Book> to show that generics reject other types.
//
// Concepts practiced: abstract classes, inheritance, interfaces, mixins,
// generics, enums, extensions, polymorphism.
//
// ---------------------------- SOLUTION --------------------------------

void main() {
  // ---------- Products ----------
  Book cleanCode = Book('B1', 'Clean Code', 150, author: 'Robert Martin');
  Book dartBook = Book('B2', 'Dart Apprentice', 200, author: 'Jonathan Sande');
  Electronics laptop = Electronics('E1', 'Laptop', 20000, warrantyMonths: 24);
  Electronics mouse = Electronics('E2', 'Wireless Mouse', 500, warrantyMonths: 12);
  Clothing tshirt = Clothing('C1', 'T-Shirt', 300, size: 'M');
  Clothing jacket = Clothing('C2', 'Jacket', 1200, size: 'L');

  List<Product> catalog = [cleanCode, dartBook, laptop, mouse, tshirt, jacket];

  // ---------- Catalog (polymorphism) ----------
  print('===== Catalog =====');
  for (Product p in catalog) {
    String discount = p is Discountable
        ? '  (${(p as Discountable).discountPercent.toStringAsFixed(0)}% off)'
        : '';
    print('${p.category.padRight(12)} ${p.name.padRight(16)} '
        '${p.priceWithTax.egp}$discount');
  }

  // ---------- Cart ----------
  print('\n===== Cart =====');
  Cart<Product> cart = Cart<Product>();
  cart.add(laptop);
  cart.add(dartBook, 2);
  cart.add(tshirt, 3);
  cart.printCart();

  try {
    cart.add(mouse, 0); // invalid quantity
  } on ArgumentError catch (e) {
    print('Rejected: ${e.message}');
  }

  cart.remove(dartBook);
  print('After removing the Dart book:');
  cart.printCart();

  // ---------- Generics: a cart that only accepts Books ----------
  print('\n===== Cart<Book> =====');
  Cart<Book> bookCart = Cart<Book>();
  bookCart.add(cleanCode);
  // bookCart.add(laptop); // ERROR at compile time: Electronics is not a Book
  bookCart.printCart();

  // ---------- Order ----------
  print('\n===== Order =====');
  Order order = Order.fromCart(cart);
  print(order);

  while (order.status.next != null) {
    order.advance();
    print(order);
  }

  // cancel is not allowed anymore (delivered)
  try {
    order.cancel();
  } on StateError catch (e) {
    print('Cancel rejected: ${e.message}');
  }

  // A second order that CAN be cancelled
  Cart<Product> cart2 = Cart<Product>()..add(mouse, 2);
  Order order2 = Order.fromCart(cart2);
  order2.advance(); // pending -> paid
  order2.cancel(); // allowed while paid
  print(order2);

  // Expected totals:
  //   laptop 20000 x1.14 = 22800 -> -10% = 20520.00
  //   dart book 200 x2 = 400.00 (removed later)
  //   t-shirt 300 x1.10 = 330 -> -20% = 264.00 x3 = 792.00
  //   first cart total (before removing the book) = 21712.00
  //   after removing the book                      = 21312.00
}

// ===============================================================
// 7) extension on double
// ===============================================================
extension MoneyFormat on double {
  String get egp => '${toStringAsFixed(2)} EGP';
}

// ===============================================================
// 3) mixin
// ===============================================================
mixin Loggable {
  void log(String message) => print('[$runtimeType] $message');
}

// ===============================================================
// 2) interface
// ===============================================================
abstract class Discountable {
  double get discountPercent;
}

// ===============================================================
// 1) Products
// ===============================================================
abstract class Product {
  final String id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price) {
    if (price < 0) throw ArgumentError('Price cannot be negative');
  }

  double get taxRate;
  String get category;

  double get priceWithTax => price * (1 + taxRate);

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$category: $name';
}

class Book extends Product {
  final String author;

  Book(super.id, super.name, super.price, {required this.author});

  @override
  double get taxRate => 0;

  @override
  String get category => 'Book';
}

class Electronics extends Product implements Discountable {
  final int warrantyMonths;

  Electronics(super.id, super.name, super.price, {required this.warrantyMonths});

  @override
  double get taxRate => 0.14;

  @override
  String get category => 'Electronics';

  @override
  double get discountPercent => 10;
}

class Clothing extends Product implements Discountable {
  final String size;

  Clothing(super.id, super.name, super.price, {required this.size});

  @override
  double get taxRate => 0.10;

  @override
  String get category => 'Clothing';

  @override
  double get discountPercent => 20;
}

/// Price of ONE unit after tax and (when available) discount.
double unitPrice(Product product) {
  double price = product.priceWithTax;
  if (product is Discountable) {
    price *= 1 - (product as Discountable).discountPercent / 100;
  }
  return price;
}

// ===============================================================
// 4) Generic cart
// ===============================================================
class Cart<T extends Product> with Loggable {
  final Map<T, int> _lines = {};

  Map<T, int> get lines => Map.unmodifiable(_lines);

  bool get isEmpty => _lines.isEmpty;

  void add(T product, [int quantity = 1]) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than zero');
    }
    // Same product again -> increase the quantity.
    _lines[product] = (_lines[product] ?? 0) + quantity;
    log('added $quantity x ${product.name}');
  }

  void remove(T product) {
    if (_lines.remove(product) != null) {
      log('removed ${product.name}');
    }
  }

  double get total => _lines.entries.fold<double>(
        0,
        (sum, line) => sum + unitPrice(line.key) * line.value,
      );

  void printCart() {
    if (_lines.isEmpty) {
      print('  (the cart is empty)');
      return;
    }
    _lines.forEach((product, quantity) {
      double lineTotal = unitPrice(product) * quantity;
      print('  $quantity x ${product.name.padRight(16)} ${lineTotal.egp}');
    });
    print('  TOTAL: ${total.egp}');
  }
}

// ===============================================================
// 5) Enum
// ===============================================================
enum OrderStatus {
  pending('Pending'),
  paid('Paid'),
  shipped('Shipped'),
  delivered('Delivered'),
  cancelled('Cancelled');

  const OrderStatus(this.label);

  final String label;

  /// The following status, or null when there is none.
  OrderStatus? get next => switch (this) {
        OrderStatus.pending => OrderStatus.paid,
        OrderStatus.paid => OrderStatus.shipped,
        OrderStatus.shipped => OrderStatus.delivered,
        OrderStatus.delivered || OrderStatus.cancelled => null,
      };

  bool get canCancel =>
      this == OrderStatus.pending || this == OrderStatus.paid;
}

// ===============================================================
// 6) Order
// ===============================================================
class Order with Loggable {
  static int _nextId = 1;

  final int id;
  final Map<Product, int> items;
  final double total;
  OrderStatus _status = OrderStatus.pending;

  Order._(this.items, this.total) : id = _nextId++;

  /// Builds an order from a cart (copies the data, so later changes
  /// to the cart do not affect the order).
  factory Order.fromCart(Cart<Product> cart) {
    if (cart.isEmpty) throw StateError('Cannot create an order from an empty cart');
    return Order._(Map.of(cart.lines), cart.total);
  }

  OrderStatus get status => _status;

  void advance() {
    OrderStatus? next = _status.next;
    if (next == null) {
      throw StateError('Order #$id is already ${_status.label}');
    }
    _status = next;
    log('order #$id is now ${_status.label}');
  }

  void cancel() {
    if (!_status.canCancel) {
      throw StateError(
          'Order #$id cannot be cancelled when it is ${_status.label}');
    }
    _status = OrderStatus.cancelled;
    log('order #$id cancelled');
  }

  @override
  String toString() =>
      'Order #$id | ${items.length} product(s) | ${total.egp} | ${_status.label}';
}
