// =============================================================
// Session 3 | Guided Lab: BankAccount and Student
// Skills practiced: fields, constructors (named, initializer list),
//   encapsulation, getters/setters, static, toString, ==/hashCode
// Run with:  dart run 05_guided_lab_bank_and_student.dart
//
// How to run this lab in class:
//   The file is organised in numbered STEPS. Build the classes at the
//   bottom step by step with the students, then use the calls in `main`
//   to check each step.
// =============================================================

void main() {
  // ===================== PART A: BankAccount =====================
  print('===== PART A: BankAccount =====');

  // STEP A1-A2: create accounts (constructor + static account numbers)
  BankAccount ali = BankAccount('Ali', initialDeposit: 1000);
  BankAccount mona = BankAccount('Mona');
  print(ali);
  print(mona);

  // STEP A3: deposit and withdraw
  ali.deposit(500);
  ali.withdraw(200);
  print('Ali balance: ${ali.balance}');

  // STEP A4: validation with exceptions
  try {
    ali.deposit(-50);
  } on ArgumentError catch (e) {
    print('Deposit rejected: ${e.message}');
  }
  try {
    mona.withdraw(100); // Mona has 0
  } on StateError catch (e) {
    print('Withdraw rejected: ${e.message}');
  }

  // STEP A5: transfer between two objects
  ali.transfer(mona, 300);
  print('After transfer -> Ali: ${ali.balance}, Mona: ${mona.balance}');

  // STEP A6: read-only transaction history (list is protected)
  print('Ali transactions:');
  for (String line in ali.transactions) {
    print('  $line');
  }
  print('Accounts created: ${BankAccount.totalAccounts}');

  // ===================== PART B: Student =====================
  print('\n===== PART B: Student =====');

  // STEP B1: normal constructor and a named constructor
  Student s1 = Student('Sara', 1001);
  Student s2 = Student.fromCsv('Omar,1002,Math:90;Physics:75;Chemistry:82');
  print(s1);
  print(s2);

  // STEP B2: add grades with validation
  s1.addGrade('Math', 95);
  s1.addGrade('Physics', 88);
  s1.addGrade('Chemistry', 79);
  try {
    s1.addGrade('Biology', 120);
  } on ArgumentError catch (e) {
    print('Grade rejected: ${e.message}');
  }

  // STEP B3: computed getters
  print('Sara average: ${s1.average.toStringAsFixed(1)} -> ${s1.letterGrade}');
  print('Omar average: ${s2.average.toStringAsFixed(1)} -> ${s2.letterGrade}');

  // STEP B4: equality based on the student id
  Student duplicate = Student('Sara (copy)', 1001);
  print('s1 == duplicate (same id)? ${s1 == duplicate}'); // true
  print('s1 == s2? ${s1 == s2}'); // false

  // STEP B5: a Set removes duplicate students automatically
  Set<Student> roster = {s1, s2, duplicate};
  print('Roster size: ${roster.length}'); // 2
}

// ===============================================================
// BankAccount
// ===============================================================
class BankAccount {
  // STEP A1: static counter shared by ALL accounts
  static int _nextNumber = 1000;
  static int get totalAccounts => _nextNumber - 1000;

  final int accountNumber; // never changes
  final String owner;
  double _balance; // private: only changed through methods
  final List<String> _transactions = [];

  // STEP A2: constructor with a named parameter and an initializer list
  BankAccount(this.owner, {double initialDeposit = 0})
      : assert(initialDeposit >= 0, 'Initial deposit cannot be negative'),
        accountNumber = _nextNumber++,
        _balance = initialDeposit {
    if (initialDeposit > 0) _transactions.add('Opened with $initialDeposit');
  }

  // Getter: read-only access to the balance
  double get balance => _balance;

  List<String> get transactions => List.unmodifiable(_transactions);

  // STEP A3: deposit
  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Deposit must be greater than zero');
    }
    _balance += amount;
    _transactions.add('Deposit +$amount');
  }

  // STEP A3-A4: withdraw with validation
  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Withdrawal must be greater than zero');
    }
    if (amount > _balance) {
      throw StateError('Insufficient funds: balance is $_balance');
    }
    _balance -= amount;
    _transactions.add('Withdraw -$amount');
  }

  // STEP A5: transfer reuses withdraw and deposit
  void transfer(BankAccount to, double amount) {
    withdraw(amount);
    to.deposit(amount);
    _transactions.add('Transfer to #${to.accountNumber}: $amount');
  }

  @override
  String toString() => 'Account #$accountNumber ($owner): $_balance EGP';
}

// ===============================================================
// Student
// ===============================================================
class Student {
  final String name;
  final int id;
  final Map<String, double> _grades = {};

  // STEP B1: main constructor
  Student(this.name, this.id);

  // STEP B1: named constructor that parses text such as
  //   'Omar,1002,Math:90;Physics:75'
  factory Student.fromCsv(String line) {
    List<String> parts = line.split(',');
    Student student = Student(parts[0].trim(), int.parse(parts[1].trim()));
    if (parts.length > 2 && parts[2].isNotEmpty) {
      for (String pair in parts[2].split(';')) {
        List<String> kv = pair.split(':');
        student.addGrade(kv[0].trim(), double.parse(kv[1]));
      }
    }
    return student;
  }

  // STEP B2: controlled way to add data
  void addGrade(String subject, double grade) {
    if (grade < 0 || grade > 100) {
      throw ArgumentError('Grade must be between 0 and 100 (got $grade)');
    }
    _grades[subject] = grade;
  }

  // STEP B3: computed getters
  double get average {
    if (_grades.isEmpty) return 0;
    double sum = 0;
    for (double g in _grades.values) {
      sum += g;
    }
    return sum / _grades.length;
  }

  String get letterGrade {
    double avg = average;
    if (avg >= 90) return 'A';
    if (avg >= 80) return 'B';
    if (avg >= 70) return 'C';
    if (avg >= 60) return 'D';
    return 'F';
  }

  // STEP B4-B5: two students are the same when they share the same id
  @override
  bool operator ==(Object other) => other is Student && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Student($name, #$id, ${_grades.length} grades, avg ${average.toStringAsFixed(1)})';
}
