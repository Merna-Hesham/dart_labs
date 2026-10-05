// =============================================================
// Session 2 | Part 4: Higher-order collection methods
//   map, where, reduce, fold, any, every, sort, ...
// Run with:  dart run 04_higher_order_methods.dart
// =============================================================

void main() {
  List<int> numbers = [5, 2, 8, 1, 9, 4, 6];
  print('Original: $numbers\n');

  // ---------------------------------------------------------
  // forEach: do something for each item (returns nothing)
  // ---------------------------------------------------------
  print('forEach:');
  numbers.forEach((n) => print('  item $n'));

  // ---------------------------------------------------------
  // map: TRANSFORM each item into a new one.
  // It returns a lazy Iterable, so call .toList() to get a List.
  // ---------------------------------------------------------
  List<int> doubled = numbers.map((n) => n * 2).toList();
  print('\nmap (x2)        : $doubled');

  List<String> asText = numbers.map((n) => 'No.$n').toList();
  print('map (to String) : $asText');

  // ---------------------------------------------------------
  // where: FILTER, keep only items that pass a test
  // ---------------------------------------------------------
  List<int> evens = numbers.where((n) => n % 2 == 0).toList();
  print('where (even)    : $evens');

  // ---------------------------------------------------------
  // reduce: combine all items into ONE value (list must not be empty)
  // ---------------------------------------------------------
  int sum = numbers.reduce((a, b) => a + b);
  int biggest = numbers.reduce((a, b) => a > b ? a : b);
  print('reduce (sum)    : $sum');
  print('reduce (max)    : $biggest');

  // ---------------------------------------------------------
  // fold: like reduce but with a STARTING value (safe on empty
  // lists, and the result type may differ from the item type)
  // ---------------------------------------------------------
  int total = numbers.fold(0, (previous, n) => previous + n);
  double average = numbers.isEmpty ? 0 : total / numbers.length;
  print('fold (sum)      : $total');
  print('average         : ${average.toStringAsFixed(2)}');

  // ---------------------------------------------------------
  // any / every: true/false questions about the whole list
  // ---------------------------------------------------------
  print('any > 8?        : ${numbers.any((n) => n > 8)}'); // true
  print('every > 0?      : ${numbers.every((n) => n > 0)}'); // true
  print('every even?     : ${numbers.every((n) => n.isEven)}'); // false

  // ---------------------------------------------------------
  // firstWhere / singleWhere / indexWhere: search
  // ---------------------------------------------------------
  int firstBig = numbers.firstWhere((n) => n > 5);
  print('firstWhere > 5  : $firstBig');

  // orElse avoids a crash when nothing matches
  int notFound = numbers.firstWhere((n) => n > 100, orElse: () => -1);
  print('firstWhere > 100: $notFound');

  // ---------------------------------------------------------
  // sort: with a comparison function (a, b) -> negative/0/positive
  // ---------------------------------------------------------
  List<int> sortedAsc = [...numbers]..sort(); // copy first, then sort
  List<int> sortedDesc = [...numbers]..sort((a, b) => b.compareTo(a));
  print('sort ascending  : $sortedAsc');
  print('sort descending : $sortedDesc');

  // ---------------------------------------------------------
  // take / skip: slicing
  // ---------------------------------------------------------
  print('take(3)         : ${numbers.take(3).toList()}');
  print('skip(3)         : ${numbers.skip(3).toList()}');

  // ---------------------------------------------------------
  // CHAINING: combine several operations in a pipeline
  // "square the even numbers, keep those above 10, then sum"
  // ---------------------------------------------------------
  int result = numbers
      .where((n) => n.isEven)
      .map((n) => n * n)
      .where((n) => n > 10)
      .fold(0, (sum, n) => sum + n);
  print('\nChained result  : $result'); // 64 + 16 + 36 = 116

  // ---------------------------------------------------------
  // Real-world style: a list of Maps (like JSON data)
  // ---------------------------------------------------------
  List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 15000, 'inStock': true},
    {'name': 'Mouse', 'price': 300, 'inStock': true},
    {'name': 'Monitor', 'price': 4000, 'inStock': false},
    {'name': 'Keyboard', 'price': 800, 'inStock': true},
  ];

  var available = products.where((p) => p['inStock'] == true);
  var names = available.map((p) => p['name']).toList();
  num totalPrice =
      available.fold<num>(0, (sum, p) => sum + (p['price'] as num));
  print('Available products: $names');
  print('Their total price : $totalPrice');

  // Sort the products by price (cheapest first)
  products.sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
  print('By price: ${products.map((p) => p['name']).toList()}');

  // Group products by availability using a Map
  Map<bool, List<String>> grouped = {true: [], false: []};
  for (var p in products) {
    grouped[p['inStock'] as bool]!.add(p['name'] as String);
  }
  print('Grouped: $grouped');
}
