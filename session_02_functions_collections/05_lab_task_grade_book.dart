// =============================================================
// Session 2 | LAB TASK (instructor solution): Student Grade Book
// Requirements:
//   - store students and their marks in a Map
//   - compute each student's average
//   - find the top scorer
//   - print a sorted ranking
// Skills practiced: Map, List, functions, higher-order methods
// Run with:  dart run 07_lab_task_grade_book.dart
// =============================================================

void main() {
  // Each student maps to a list of marks (out of 100).
  Map<String, List<int>> gradeBook = {
    'Ali': [85, 90, 78],
    'Mona': [95, 88, 92],
    'Omar': [60, 70, 65],
    'Laila': [88, 92, 79],
    'Nour': [45, 55, 50],
  };

  // ------------------- 1) Averages -------------------
  Map<String, double> averages = calculateAverages(gradeBook);
  print('=== Averages ===');
  averages.forEach((name, avg) {
    print('${name.padRight(6)} : ${avg.toStringAsFixed(2)}');
  });

  // ------------------- 2) Top scorer -------------------
  String top = findTopStudent(averages);
  print('\nTop scorer: $top (${averages[top]!.toStringAsFixed(2)})');

  // ------------------- 3) Ranking -------------------
  print('\n=== Ranking ===');
  List<MapEntry<String, double>> ranking = rankStudents(averages);
  for (int i = 0; i < ranking.length; i++) {
    MapEntry<String, double> entry = ranking[i];
    print('${i + 1}. ${entry.key.padRight(6)} '
        '${entry.value.toStringAsFixed(2)}  ${letterGrade(entry.value)}');
  }

  // ------------------- 4) Extra statistics -------------------
  print('\n=== Class statistics ===');
  List<double> allAverages = averages.values.toList();
  double classAverage =
      allAverages.reduce((a, b) => a + b) / allAverages.length;
  List<String> passed =
      averages.entries.where((e) => e.value >= 50).map((e) => e.key).toList();
  List<String> failed =
      averages.entries.where((e) => e.value < 50).map((e) => e.key).toList();

  print('Class average : ${classAverage.toStringAsFixed(2)}');
  print('Passed        : $passed');
  print('Failed        : $failed');

  // ------------------- 5) Count of each letter grade -------------------
  Map<String, int> distribution = {};
  for (double avg in allAverages) {
    String grade = letterGrade(avg);
    distribution[grade] = (distribution[grade] ?? 0) + 1;
  }
  print('Grade distribution: $distribution');
}

/// Converts each student's list of marks into one average.
Map<String, double> calculateAverages(Map<String, List<int>> gradeBook) {
  Map<String, double> result = {};
  gradeBook.forEach((name, marks) {
    // Guard against an empty list to avoid dividing by zero.
    double average = marks.isEmpty
        ? 0
        : marks.fold<int>(0, (sum, m) => sum + m) / marks.length;
    result[name] = average;
  });
  return result;
}

/// Returns the name with the highest average.
String findTopStudent(Map<String, double> averages) {
  return averages.entries
      .reduce((best, current) => current.value > best.value ? current : best)
      .key;
}

/// Returns the entries sorted from highest to lowest average.
List<MapEntry<String, double>> rankStudents(Map<String, double> averages) {
  List<MapEntry<String, double>> entries = averages.entries.toList();
  entries.sort((a, b) => b.value.compareTo(a.value)); // descending
  return entries;
}

/// Converts an average to a letter grade.
String letterGrade(double average) {
  if (average >= 90) return 'A';
  if (average >= 80) return 'B';
  if (average >= 70) return 'C';
  if (average >= 60) return 'D';
  return 'F';
}
