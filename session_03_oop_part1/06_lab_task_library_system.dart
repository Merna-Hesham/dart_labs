// =====================================================================
// SESSION 3 | LAB TASK: Library System
// Run with:  dart run 06_lab_task_library_system.dart
// =====================================================================
//
// ------------------------- TASK DESCRIPTION --------------------------
//
// Build a small library system with three classes. Everything is
// printed to the console from `main` (no keyboard input).
//
// 1) class Book
//      - final fields: isbn, title, author
//      - a PRIVATE availability flag with a read-only getter `isAvailable`
//      - methods checkOut() and giveBack() that change the flag and throw a
//        StateError when the action makes no sense (already out / not out)
//      - toString() and == / hashCode based on the isbn
//
// 2) class Member
//      - a static id generator: the first member gets id 1, then 2, ...
//      - final fields: id, name
//      - a PRIVATE list of borrowed books exposed as an unmodifiable getter
//      - static const maxBooks = 3
//      - getter canBorrow (true while the member has fewer than maxBooks)
//
// 3) class Library
//      - private collections of books (by isbn) and members (by id)
//      - addBook(Book) -> false when the isbn already exists
//      - registerMember(String name) -> returns the new Member
//      - borrowBook(memberId, isbn) -> returns a message String and
//        handles: unknown member, unknown book, book not available,
//        member reached the limit
//      - returnBook(memberId, isbn) -> returns a message String
//      - searchByAuthor(String) -> case-insensitive, returns List<Book>
//      - getter availableBooks and a printReport() that shows, for every
//        book, whether it is available or who has it
//
// In `main`, run a scenario that triggers every message: add 5 books
// (including one duplicate isbn), register 2 members, borrow until the
// limit is hit, try to borrow a book that is already out, return a book,
// search by author, print the report.
//
// Concepts practiced: classes, constructors, encapsulation, getters,
// static members, toString, equality, collections of objects.
//
// ---------------------------- SOLUTION --------------------------------

void main() {
  Library library = Library();

  // ---------- Add books ----------
  print('=== Adding books ===');
  List<Book> books = [
    Book('111', 'Clean Code', 'Robert Martin'),
    Book('222', 'The Pragmatic Programmer', 'Andrew Hunt'),
    Book('333', 'Refactoring', 'Martin Fowler'),
    Book('444', 'Clean Architecture', 'Robert Martin'),
    Book('555', 'Design Patterns', 'Erich Gamma'),
    Book('111', 'Clean Code (duplicate)', 'Robert Martin'), // same isbn
  ];
  for (Book book in books) {
    bool added = library.addBook(book);
    print(added ? 'Added: $book' : 'Rejected (isbn exists): $book');
  }

  // ---------- Register members ----------
  print('\n=== Registering members ===');
  Member sara = library.registerMember('Sara');
  Member omar = library.registerMember('Omar');
  print(sara);
  print(omar);

  // ---------- Borrowing ----------
  print('\n=== Borrowing ===');
  print(library.borrowBook(sara.id, '111'));
  print(library.borrowBook(sara.id, '222'));
  print(library.borrowBook(sara.id, '333'));
  print(library.borrowBook(sara.id, '444')); // limit reached (3 books)
  print(library.borrowBook(omar.id, '111')); // already borrowed by Sara
  print(library.borrowBook(omar.id, '999')); // unknown book
  print(library.borrowBook(99, '555')); // unknown member
  print(library.borrowBook(omar.id, '555')); // OK

  // ---------- Returning ----------
  print('\n=== Returning ===');
  print(library.returnBook(sara.id, '111'));
  print(library.returnBook(sara.id, '111')); // she no longer has it
  print(library.borrowBook(omar.id, '111')); // available again

  // ---------- Searching ----------
  print('\n=== Search by author "robert martin" ===');
  for (Book b in library.searchByAuthor('robert martin')) {
    print('  $b');
  }

  // ---------- Report ----------
  print('\n=== Available books ===');
  for (Book b in library.availableBooks) {
    print('  ${b.title}');
  }

  library.printReport();

  // Encapsulation check: the getter returns an unmodifiable list, so
  // trying to add a book directly fails (it throws at runtime):
  try {
    sara.borrowedBooks.add(books.first);
  } on UnsupportedError {
    print('\nCannot cheat: borrowedBooks is read-only from outside.');
  }
}

// ===================================================================
// Book
// ===================================================================
class Book {
  final String isbn;
  final String title;
  final String author;
  bool _isAvailable = true; // private flag

  Book(this.isbn, this.title, this.author);

  bool get isAvailable => _isAvailable;

  void checkOut() {
    if (!_isAvailable) {
      throw StateError('"$title" is already checked out');
    }
    _isAvailable = false;
  }

  void giveBack() {
    if (_isAvailable) {
      throw StateError('"$title" was not checked out');
    }
    _isAvailable = true;
  }

  @override
  bool operator ==(Object other) => other is Book && other.isbn == isbn;

  @override
  int get hashCode => isbn.hashCode;

  @override
  String toString() => '[$isbn] "$title" by $author';
}

// ===================================================================
// Member
// ===================================================================
class Member {
  static int _nextId = 1;
  static const int maxBooks = 3;

  final int id;
  final String name;
  final List<Book> _borrowed = [];

  Member(this.name) : id = _nextId++;

  List<Book> get borrowedBooks => List.unmodifiable(_borrowed);

  bool get canBorrow => _borrowed.length < maxBooks;

  void addBook(Book book) => _borrowed.add(book);

  bool removeBook(Book book) => _borrowed.remove(book); // uses == on isbn

  @override
  String toString() =>
      'Member #$id $name (${_borrowed.length}/$maxBooks books)';
}

// ===================================================================
// Library
// ===================================================================
class Library {
  final Map<String, Book> _books = {}; // isbn -> Book
  final Map<int, Member> _members = {}; // id -> Member

  bool addBook(Book book) {
    if (_books.containsKey(book.isbn)) return false;
    _books[book.isbn] = book;
    return true;
  }

  Member registerMember(String name) {
    Member member = Member(name);
    _members[member.id] = member;
    return member;
  }

  String borrowBook(int memberId, String isbn) {
    Member? member = _members[memberId];
    if (member == null) return 'Error: member #$memberId does not exist';

    Book? book = _books[isbn];
    if (book == null) return 'Error: no book with isbn $isbn';

    if (!book.isAvailable) {
      return 'Sorry ${member.name}: "${book.title}" is not available';
    }
    if (!member.canBorrow) {
      return 'Sorry ${member.name}: limit of ${Member.maxBooks} books reached';
    }

    book.checkOut();
    member.addBook(book);
    return '${member.name} borrowed "${book.title}"';
  }

  String returnBook(int memberId, String isbn) {
    Member? member = _members[memberId];
    if (member == null) return 'Error: member #$memberId does not exist';

    Book? book = _books[isbn];
    if (book == null) return 'Error: no book with isbn $isbn';

    if (!member.removeBook(book)) {
      return '${member.name} does not have "${book.title}"';
    }
    book.giveBack();
    return '${member.name} returned "${book.title}"';
  }

  List<Book> searchByAuthor(String text) {
    String query = text.toLowerCase();
    return _books.values
        .where((book) => book.author.toLowerCase().contains(query))
        .toList();
  }

  List<Book> get availableBooks =>
      _books.values.where((book) => book.isAvailable).toList();

  void printReport() {
    print('\n=========== LIBRARY REPORT ===========');
    for (Book book in _books.values) {
      String holder = 'available';
      if (!book.isAvailable) {
        // Find the member who currently has this book.
        for (Member m in _members.values) {
          if (m.borrowedBooks.contains(book)) holder = 'with ${m.name}';
        }
      }
      print('${book.title.padRight(26)} $holder');
    }
    print('Members: ${_members.length}, Books: ${_books.length}, '
        'Available: ${availableBooks.length}');
    print('======================================');
  }
}
