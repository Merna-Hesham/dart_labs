// =============================================================
// Session 2 | Part 3: Collections (List, Set, Map)
// Run with:  dart run 03_collections.dart
// =============================================================

void main() {
  listDemo();
  setDemo();
  mapDemo();
  collectionOperatorsDemo();
}

// -------------------------------------------------------------
// LIST: ordered, allows duplicates, accessed by index (from 0)
// -------------------------------------------------------------
void listDemo() {
  print('\n===== LIST =====');

  List<String> fruits = ['apple', 'banana', 'orange'];
  print('List: $fruits');
  print('First: ${fruits.first}, Last: ${fruits.last}');
  print('Index 1: ${fruits[1]}');
  print('Length: ${fruits.length}');

  fruits.add('mango'); // add to the end
  fruits.addAll(['kiwi', 'grape']); // add many
  fruits.insert(1, 'lemon'); // insert at an index
  print('After adding: $fruits');

  fruits.remove('banana'); // remove by value
  fruits.removeAt(0); // remove by index
  print('After removing: $fruits');

  print('Contains mango? ${fruits.contains('mango')}');
  print('Index of kiwi: ${fruits.indexOf('kiwi')}');
  print('isEmpty: ${fruits.isEmpty}, isNotEmpty: ${fruits.isNotEmpty}');

  // Sorting and reversing
  fruits.sort(); // alphabetical, changes the original list
  print('Sorted: $fruits');
  print('Reversed: ${fruits.reversed.toList()}');

  // Sub-list
  print('First two: ${fruits.sublist(0, 2)}');

  // Loop through a list
  for (int i = 0; i < fruits.length; i++) {
    print('  [$i] ${fruits[i]}');
  }

  // Fixed-length and generated lists
  List<int> zeros = List.filled(3, 0); // [0, 0, 0]
  List<int> squares = List.generate(5, (i) => i * i); // [0, 1, 4, 9, 16]
  print('Filled: $zeros | Generated: $squares');

  // const list: cannot be changed at all
  const List<int> fixed = [1, 2, 3];
  // fixed.add(4); // ERROR at runtime: unmodifiable list
  print('Const list: $fixed');
}

// -------------------------------------------------------------
// SET: unordered-style collection of UNIQUE values
// -------------------------------------------------------------
void setDemo() {
  print('\n===== SET =====');

  Set<int> numbers = {1, 2, 3, 3, 2, 1}; // duplicates are ignored
  print('Set: $numbers'); // {1, 2, 3}

  numbers.add(4);
  bool added = numbers.add(4); // false: 4 already exists
  print('Added 4 again? $added');

  Set<int> a = {1, 2, 3, 4};
  Set<int> b = {3, 4, 5, 6};
  print('Union:        ${a.union(b)}'); // everything
  print('Intersection: ${a.intersection(b)}'); // in both
  print('Difference:   ${a.difference(b)}'); // in a but not in b

  // A common trick: remove duplicates from a list
  List<String> withDuplicates = ['a', 'b', 'a', 'c', 'b'];
  List<String> unique = withDuplicates.toSet().toList();
  print('Unique: $unique');
}

// -------------------------------------------------------------
// MAP: key -> value pairs; keys are unique
// -------------------------------------------------------------
void mapDemo() {
  print('\n===== MAP =====');

  Map<String, int> ages = {'Ali': 20, 'Mona': 22, 'Omar': 21};
  print('Map: $ages');
  print('Mona is ${ages['Mona']}'); // read by key

  ages['Laila'] = 23; // add a new pair
  ages['Ali'] = 21; // update an existing pair
  print('After changes: $ages');

  // A missing key returns null, so the type is int? (nullable)
  int? unknown = ages['Zed'];
  print('Zed: $unknown');
  print('Zed with default: ${ages['Zed'] ?? 0}');

  ages.remove('Omar');
  print('Contains key Ali? ${ages.containsKey('Ali')}');
  print('Contains value 22? ${ages.containsValue(22)}');
  print('Keys: ${ages.keys}');
  print('Values: ${ages.values}');

  // Loop through a map
  ages.forEach((name, age) {
    print('  $name -> $age');
  });
  for (var entry in ages.entries) {
    print('  Entry: ${entry.key} is ${entry.value}');
  }

  // putIfAbsent: add only when the key does not exist
  ages.putIfAbsent('Ali', () => 99); // ignored: Ali exists
  ages.putIfAbsent('Nour', () => 19); // added
  print('After putIfAbsent: $ages');

  // A map of lists (very common with real data)
  Map<String, List<int>> marks = {
    'Ali': [80, 90],
    'Mona': [95, 100],
  };
  print('Mona marks: ${marks['Mona']}');
}

// -------------------------------------------------------------
// COLLECTION OPERATORS: spread, collection if, collection for
// (they are used constantly to build Flutter widget lists)
// -------------------------------------------------------------
void collectionOperatorsDemo() {
  print('\n===== SPREAD / COLLECTION IF / COLLECTION FOR =====');

  List<int> first = [1, 2, 3];
  List<int> second = [4, 5];

  // Spread operator ...  copies all items into the new list
  List<int> all = [...first, ...second, 6];
  print('Spread: $all');

  // Null-aware spread ...?  (safe when the list may be null)
  List<int>? maybeNull;
  List<int> safe = [0, ...?maybeNull];
  print('Null-aware spread: $safe');

  // Collection if: include an item only when a condition is true
  bool isLoggedIn = true;
  List<String> menu = [
    'Home',
    'Products',
    if (isLoggedIn) 'Profile',
    if (!isLoggedIn) 'Login',
  ];
  print('Menu: $menu');

  // Collection for: build a list from a loop, inside the literal
  List<String> labels = [
    for (int i = 1; i <= 3; i++) 'Lab $i',
  ];
  print('Labels: $labels');
}
