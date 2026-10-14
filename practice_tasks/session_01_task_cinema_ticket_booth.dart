// =====================================================================
// SESSION 1 | LAB TASK: Cinema Ticket Booth
// Run with:  dart run session_01_task_cinema_ticket_booth.dart
// =====================================================================
//
// ------------------------- TASK DESCRIPTION --------------------------
//
// Write ONE program (everything inside `main`) that prints a receipt
// for a cinema customer. All inputs are hard-coded variables at the top
// of `main`, so no keyboard input is needed:
//
//   String customerName   e.g. 'sara ahmed'
//   int?   age            may be null (age not provided)
//   String day            e.g. 'Saturday'
//   int    tickets        how many tickets are bought
//   bool   isStudent      student card shown or not
//
// Requirements:
//   1. The base ticket price is 100 EGP.
//   2. If `age` is null, treat the customer as an adult (use `??`).
//   3. Discounts (they do NOT stack):
//        - age under 6                 -> free
//        - age 6 to 17, or 65 and over -> half price
//        - a student                   -> half price
//   4. Friday, Saturday and Sunday add a 20% weekend surcharge
//      (use a `switch`).
//   5. Compute: subtotal = price per ticket x tickets,
//               tax      = 14% of the subtotal,
//               total    = subtotal + tax.
//   6. Print the customer name in Title Case ('sara ahmed' -> 'Sara Ahmed').
//   7. Print a formatted receipt using a multi-line string (''') and \t,
//      with every money value shown with 2 decimals.
//   8. Loop from 1 to `tickets` and print one line per ticket,
//      for example:  Ticket 1 - Seat A1
//   9. Run the program for these three customers (change the variables
//      at the top and run again) and compare the receipts:
//        a) 'sara ahmed',  age 15,   'Saturday', 3 tickets, not a student
//        b) 'omar ali',    age null, 'Tuesday',  2 tickets, student
//        c) 'nour hassan', age 4,    'Sunday',   1 ticket,  not a student
//
// Concepts practiced: types, string interpolation, const / final, null
// safety (`int?`, `??`), arithmetic and logical operators, ternary,
// switch, for / for-in loops, string methods.
//
// ---------------------------- SOLUTION --------------------------------

void main() {
  // ---------------------------------------------------------
  // INPUTS (change these values to test different customers)
  // ---------------------------------------------------------
  String customerName = 'sara ahmed';
  int? age = 15; // try null as well
  String day = 'Saturday';
  int tickets = 3;
  bool isStudent = false;

  // ---------------------------------------------------------
  // CONSTANTS: values known before the program runs
  // ---------------------------------------------------------
  const double basePrice = 100; // EGP
  const double weekendSurcharge = 0.20; // 20%
  const double taxRate = 0.14; // 14%

  // ---------------------------------------------------------
  // STEP 1: handle the missing age with ??
  //   If age is null we assume an adult of 30.
  // ---------------------------------------------------------
  int effectiveAge = age ?? 30;

  // ---------------------------------------------------------
  // STEP 2: find the discount factor
  //   1.0 = full price, 0.5 = half price, 0.0 = free.
  //   Discounts do not stack, so we use an if / else if chain
  //   and the FIRST matching rule wins.
  // ---------------------------------------------------------
  double discountFactor;
  String discountReason;

  if (effectiveAge < 6) {
    discountFactor = 0.0;
    discountReason = 'Child under 6 (free)';
  } else if (effectiveAge <= 17 || effectiveAge >= 65) {
    discountFactor = 0.5;
    discountReason = 'Age discount (50%)';
  } else if (isStudent) {
    discountFactor = 0.5;
    discountReason = 'Student discount (50%)';
  } else {
    discountFactor = 1.0;
    discountReason = 'No discount';
  }

  // ---------------------------------------------------------
  // STEP 3: weekend surcharge using a switch expression
  //   toLowerCase() makes the check work for 'Saturday', 'saturday', ...
  // ---------------------------------------------------------
  bool isWeekend = switch (day.toLowerCase()) {
    'friday' || 'saturday' || 'sunday' => true,
    _ => false,
  };

  // ---------------------------------------------------------
  // STEP 4: price calculations
  // ---------------------------------------------------------
  double pricePerTicket = basePrice * discountFactor;
  if (isWeekend) {
    pricePerTicket *= (1 + weekendSurcharge); // compound assignment
  }

  double subtotal = pricePerTicket * tickets;
  double tax = subtotal * taxRate;
  double total = subtotal + tax;

  // ---------------------------------------------------------
  // STEP 5: Title Case for the name
  //   Split into words, capitalise the first letter of each word and
  //   lower-case the rest, then join the words back with spaces.
  // ---------------------------------------------------------
  String titleCaseName = '';
  for (String word in customerName.trim().split(' ')) {
    if (word.isEmpty) continue; // skip extra spaces
    String capitalised = word[0].toUpperCase() + word.substring(1).toLowerCase();
    titleCaseName += titleCaseName.isEmpty ? capitalised : ' $capitalised';
  }

  // ---------------------------------------------------------
  // STEP 6: print the receipt with a multi-line string
  //   \t inserts a tab so the values line up in a column.
  // ---------------------------------------------------------
  String ageText = age == null ? 'not provided' : '$age';
  String dayType = isWeekend ? 'Weekend (+20%)' : 'Weekday';

  String receipt = '''
==============================
        CINEMA RECEIPT
==============================
Customer   :\t$titleCaseName
Age        :\t$ageText
Day        :\t$day ($dayType)
Student    :\t${isStudent ? 'Yes' : 'No'}
Discount   :\t$discountReason
------------------------------
Tickets    :\t$tickets
Per ticket :\t${pricePerTicket.toStringAsFixed(2)} EGP
Subtotal   :\t${subtotal.toStringAsFixed(2)} EGP
Tax (14%)  :\t${tax.toStringAsFixed(2)} EGP
------------------------------
TOTAL      :\t${total.toStringAsFixed(2)} EGP
==============================''';
  print(receipt);

  // ---------------------------------------------------------
  // STEP 7: one line per ticket with a for loop
  // ---------------------------------------------------------
  print('\nYour tickets:');
  for (int i = 1; i <= tickets; i++) {
    print('Ticket $i - Seat A$i');
  }

  // ---------------------------------------------------------
  // EXPECTED RESULTS for the three test customers
  //   a) Sara Ahmed : age 15 -> half price (50), Saturday -> 60 per ticket,
  //      3 tickets -> subtotal 180.00, tax 25.20, total 205.20
  //   b) Omar Ali   : age null -> adult 30, student -> 50, Tuesday,
  //      2 tickets -> subtotal 100.00, tax 14.00, total 114.00
  //   c) Nour Hassan: age 4 -> free, Sunday -> 0 per ticket,
  //      1 ticket  -> subtotal 0.00, tax 0.00, total 0.00
  // ---------------------------------------------------------
}
