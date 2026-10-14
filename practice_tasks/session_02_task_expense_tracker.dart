// =====================================================================
// SESSION 2 | LAB TASK: Expense Tracker
// Run with:  dart run session_02_task_expense_tracker.dart
// =====================================================================
//
// ------------------------- TASK DESCRIPTION --------------------------
//
// Build an expense tracker. The data is a list of maps kept in `main`.
// Every map has the keys:  description (String), category (String),
// amount (double).
//
// Requirements:
//   1. void addExpense(expenses, description, category, amount)
//        - throws an ArgumentError when the description is empty
//          or the amount is 0 or less
//        - otherwise adds the expense to the list
//   2. double totalSpent(expenses)                       -> use `fold`
//   3. Map<String, double> totalPerCategory(expenses)    -> use a loop
//   4. Map<String, dynamic>? biggestExpense(expenses)    -> null if empty
//   5. List<Map<String, dynamic>> expensesAbove(expenses, {double limit = 100})
//        -> use `where`, a named parameter and a default value
//   6. Print all expenses sorted from the highest to the lowest amount,
//      with the category written in Title Case.
//   7. Print a final report: the total, plus every category's total and its
//      percentage of the grand total (1 decimal).
//   8. Test the invalid cases in `main` with try / on / finally and print
//      a message when an expense is rejected.
//
// Start with 8 to 10 sample expenses across 3 or 4 categories.
//
// Concepts practiced: functions (positional and named parameters, default
// values, return types, nullable return), List, Map, fold, where, sort,
// string methods, throw, try / on / finally.
//
// ---------------------------- SOLUTION --------------------------------

void main() {
  // The list that stores every expense.
  List<Map<String, dynamic>> expenses = [];

  // ---------------------------------------------------------
  // Fill the list with sample data using addExpense()
  // ---------------------------------------------------------
  addExpense(expenses, 'Monthly bus pass', 'transport', 250);
  addExpense(expenses, 'Lunch at campus', 'food', 45.5);
  addExpense(expenses, 'Groceries', 'food', 320);
  addExpense(expenses, 'Taxi to airport', 'transport', 180);
  addExpense(expenses, 'Dart course book', 'education', 400);
  addExpense(expenses, 'Cinema', 'entertainment', 120);
  addExpense(expenses, 'Online course', 'education', 650);
  addExpense(expenses, 'Coffee with friends', 'food', 85);
  addExpense(expenses, 'Streaming subscription', 'entertainment', 99);

  // ---------------------------------------------------------
  // Requirement 8: test the invalid cases
  // ---------------------------------------------------------
  print('=== Testing invalid expenses ===');
  tryToAdd(expenses, '', 'food', 30); // empty description
  tryToAdd(expenses, 'Free sample', 'food', 0); // amount is zero
  tryToAdd(expenses, 'Refund', 'other', -50); // negative amount
  tryToAdd(expenses, 'Notebook', 'education', 35); // valid
  print('Expenses stored now: ${expenses.length}\n');

  // ---------------------------------------------------------
  // Requirement 6: sorted list, highest amount first
  // ---------------------------------------------------------
  print('=== All expenses (highest first) ===');
  printSortedExpenses(expenses);

  // ---------------------------------------------------------
  // Requirement 4: biggest expense (may be null)
  // ---------------------------------------------------------
  Map<String, dynamic>? biggest = biggestExpense(expenses);
  if (biggest != null) {
    print('\nBiggest expense: ${biggest['description']} '
        '(${(biggest['amount'] as double).toStringAsFixed(2)} EGP)');
  }
  // An empty list returns null, so we handle it safely:
  print('Biggest of an empty list: ${biggestExpense([])}');

  // ---------------------------------------------------------
  // Requirement 5: expenses above a limit
  // ---------------------------------------------------------
  print('\n=== Expenses above the default limit (100) ===');
  for (var e in expensesAbove(expenses)) {
    print('  ${e['description']}: ${e['amount']}');
  }

  print('\n=== Expenses above 300 ===');
  for (var e in expensesAbove(expenses, limit: 300)) {
    print('  ${e['description']}: ${e['amount']}');
  }

  // ---------------------------------------------------------
  // Requirement 7: final report
  // ---------------------------------------------------------
  printReport(expenses);
}

// =====================================================================
// FUNCTIONS
// =====================================================================

/// Adds an expense after validating it.
/// Throws an [ArgumentError] when the data is not valid.
void addExpense(
  List<Map<String, dynamic>> expenses,
  String description,
  String category,
  double amount,
) {
  if (description.trim().isEmpty) {
    throw ArgumentError('The description cannot be empty.');
  }
  if (amount <= 0) {
    throw ArgumentError('The amount must be greater than zero (got $amount).');
  }

  expenses.add({
    'description': description.trim(),
    'category': category.trim().toLowerCase(), // keep categories consistent
    'amount': amount,
  });
}

/// Helper used by `main` to try an addition and report what happened.
void tryToAdd(
  List<Map<String, dynamic>> expenses,
  String description,
  String category,
  double amount,
) {
  try {
    addExpense(expenses, description, category, amount);
    print('Added: "$description" ($amount)');
  } on ArgumentError catch (e) {
    // `e.message` holds the text we passed to ArgumentError.
    print('Rejected: ${e.message}');
  } finally {
    // finally runs whether the expense was accepted or rejected.
    print('  -> check finished for "$description"');
  }
}

/// Sum of all amounts, using `fold` with a starting value of 0.
/// fold<double> tells Dart the result type, which is also safe
/// when the list is empty.
double totalSpent(List<Map<String, dynamic>> expenses) {
  return expenses.fold<double>(
    0,
    (sum, expense) => sum + (expense['amount'] as double),
  );
}

/// Total amount for each category, built with a loop.
Map<String, double> totalPerCategory(List<Map<String, dynamic>> expenses) {
  Map<String, double> totals = {};
  for (var expense in expenses) {
    String category = expense['category'] as String;
    double amount = expense['amount'] as double;
    // ?? 0 gives a starting value the first time we see a category.
    totals[category] = (totals[category] ?? 0) + amount;
  }
  return totals;
}

/// The expense with the highest amount, or null when the list is empty.
Map<String, dynamic>? biggestExpense(List<Map<String, dynamic>> expenses) {
  if (expenses.isEmpty) return null; // reduce would crash on an empty list
  return expenses.reduce(
    (best, current) =>
        (current['amount'] as double) > (best['amount'] as double)
            ? current
            : best,
  );
}

/// Expenses whose amount is above [limit]. `limit` is a named parameter
/// with a default value, so callers may skip it.
List<Map<String, dynamic>> expensesAbove(
  List<Map<String, dynamic>> expenses, {
  double limit = 100,
}) {
  return expenses
      .where((expense) => (expense['amount'] as double) > limit)
      .toList();
}

/// 'food' -> 'Food', 'public transport' -> 'Public Transport'
String toTitleCase(String text) {
  return text
      .split(' ')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}

/// Prints the expenses sorted from the highest amount to the lowest.
void printSortedExpenses(List<Map<String, dynamic>> expenses) {
  // Copy first so the original list keeps its order.
  List<Map<String, dynamic>> sorted = [...expenses];
  sorted.sort(
    (a, b) => (b['amount'] as double).compareTo(a['amount'] as double),
  );

  for (var expense in sorted) {
    String description = (expense['description'] as String).padRight(24);
    String category = toTitleCase(expense['category'] as String).padRight(14);
    String amount = (expense['amount'] as double).toStringAsFixed(2).padLeft(9);
    print('$description $category $amount EGP');
  }
}

/// Final report with totals and percentages.
void printReport(List<Map<String, dynamic>> expenses) {
  double grandTotal = totalSpent(expenses);
  Map<String, double> perCategory = totalPerCategory(expenses);

  print('\n=========== EXPENSE REPORT ===========');
  print('Number of expenses : ${expenses.length}');
  print('Grand total        : ${grandTotal.toStringAsFixed(2)} EGP');
  print('--------------------------------------');

  // Sort categories from the biggest total to the smallest.
  List<MapEntry<String, double>> entries = perCategory.entries.toList();
  entries.sort((a, b) => b.value.compareTo(a.value));

  for (var entry in entries) {
    // Guard against dividing by zero when there are no expenses.
    double percent = grandTotal == 0 ? 0 : entry.value / grandTotal * 100;
    String name = toTitleCase(entry.key).padRight(15);
    String amount = entry.value.toStringAsFixed(2).padLeft(9);
    print('$name $amount EGP   ${percent.toStringAsFixed(1)}%');
  }
  print('======================================');
}
