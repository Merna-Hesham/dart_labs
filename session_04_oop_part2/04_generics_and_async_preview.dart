// =============================================================
// Session 4 | Part 4: Generics and an async preview
// Run with:  dart run 04_generics_and_async_preview.dart
// =============================================================
//
// GENERICS: write a class or function ONCE and let it work with many
// types, while Dart still checks the types for you.
// You already use them: List<int>, Map<String, double>, Set<String>.

// `main` is `async` because Part 2 uses `await`.
Future<void> main() async {
  genericsDemo();
  await asyncDemo();
}

// ===============================================================
// PART 1: GENERICS
// ===============================================================

/// Generic function: T is a placeholder for "some type".
T firstOf<T>(List<T> items) {
  if (items.isEmpty) throw StateError('The list is empty');
  return items.first;
}

/// Generic class with ONE type parameter.
class Box<T> {
  T value;

  Box(this.value);

  void replace(T newValue) => value = newValue;

  @override
  String toString() => 'Box<$T>($value)';
}

/// A generic data structure: last in, first out.
class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() {
    if (_items.isEmpty) throw StateError('Cannot pop from an empty stack');
    return _items.removeLast();
  }

  T get peek {
    if (_items.isEmpty) throw StateError('The stack is empty');
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Stack$_items';
}

/// Two type parameters.
class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  /// Returns a pair with the types swapped: Pair<A, B> -> Pair<B, A>
  Pair<B, A> swap() => Pair(second, first);

  @override
  String toString() => '($first, $second)';
}

/// Bounded generic: T must be Comparable, so we may call compareTo.
T maxOf<T extends Comparable>(List<T> items) {
  T best = items.first;
  for (T item in items) {
    if (item.compareTo(best) > 0) best = item;
  }
  return best;
}

void genericsDemo() {
  print('===== GENERICS =====');

  // Generic function: T is inferred from the argument
  print('firstOf ints    : ${firstOf([10, 20, 30])}');
  print('firstOf strings : ${firstOf(['a', 'b'])}');

  // Generic class: each Box is locked to ONE type
  Box<int> number = Box(5);
  Box<String> text = Box('Dart');
  number.replace(10);
  print('$number | $text');
  // number.replace('ten'); // ERROR: a String is not an int

  // Stack<T>
  Stack<String> history = Stack<String>();
  history.push('home');
  history.push('settings');
  history.push('profile');
  print(history);
  print('peek: ${history.peek}, pop: ${history.pop()}, now: $history');

  try {
    Stack<int> empty = Stack<int>();
    empty.pop();
  } on StateError catch (e) {
    print('Error: ${e.message}');
  }

  // Pair<A, B>
  Pair<String, int> entry = Pair('age', 25);
  Pair<int, String> swapped = entry.swap();
  print('$entry -> swapped $swapped');

  // Bounded generic works for any Comparable: numbers, strings, ...
  print('maxOf numbers : ${maxOf([3, 9, 4])}');
  print('maxOf words   : ${maxOf(['pear', 'apple', 'zebra'])}');
  print('maxOf doubles : ${maxOf([1.5, 0.2, 7.25])}');

  // The collection types are generic too
  Map<String, List<int>> marks = {
    'Ali': [80, 90],
    'Mona': [95],
  };
  print('Generic Map of Lists: $marks');
}

// ===============================================================
// PART 2: ASYNC PREVIEW (the full topic comes in Session 7)
// A Future is a value that will be available LATER.
// `async` marks a function that uses await; `await` waits for a Future
// without freezing the program.
// ===============================================================

Future<String> fetchGreeting() async {
  await Future.delayed(const Duration(seconds: 1)); // pretend: network call
  return 'Hello from the future!';
}

Future<int> loadItem(int number) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return number * 10;
}

Future<int> failingTask() async {
  await Future.delayed(const Duration(milliseconds: 200));
  throw Exception('Server not reachable');
}

/// A Stream delivers MANY values over time (`async*` + `yield`).
Stream<int> countdown(int from) async* {
  for (int i = from; i >= 1; i--) {
    await Future.delayed(const Duration(milliseconds: 300));
    yield i;
  }
}

Future<void> asyncDemo() async {
  print('\n===== ASYNC PREVIEW =====');

  // 1) await: code below runs only after the Future completes
  print('Requesting greeting...');
  String greeting = await fetchGreeting();
  print(greeting);

  // 2) one after another: about 1.5 seconds in total
  Stopwatch watch = Stopwatch()..start();
  int a = await loadItem(1);
  int b = await loadItem(2);
  int c = await loadItem(3);
  print('Sequential: [$a, $b, $c] in ${watch.elapsedMilliseconds} ms');

  // 3) all together with Future.wait: about 0.5 seconds in total
  watch.reset();
  List<int> results = await Future.wait([
    loadItem(1),
    loadItem(2),
    loadItem(3),
  ]);
  print('Parallel  : $results in ${watch.elapsedMilliseconds} ms');

  // 4) errors in async code are handled with try / catch as usual
  try {
    await failingTask();
  } catch (e) {
    print('Caught async error: $e');
  }

  // 5) Streams: `await for` receives each value as it arrives
  print('Countdown:');
  await for (int n in countdown(3)) {
    print('  $n');
  }
  print('Liftoff!');
}
