# Dart Labs: Sessions 1 to 3

## Setup
1. Install the Dart SDK (included with Flutter): https://dart.dev/get-dart
2. Check it works: `dart --version` (Dart 3.0 or newer is required, because the code uses records and switch expressions)
3. Run any file from its folder: `dart run file_name.dart`
   No project or `pubspec.yaml` is needed. You can also paste a file into https://dartpad.dev (except files that read keyboard input with `dart:io`).

## Session 1: Dart fundamentals (`session_01_dart_fundamentals/`)
| File | Topic | Type |
| --- | --- | --- |
| 01_hello_and_variables.dart | `main`, `print`, `var`, `final`, `const`, `late`, interpolation | Theory demo |
| 02_types_and_null_safety.dart | int, double, String, `?`, `??`, `?.`, `!`, `is` | Theory demo |
| 03_operators.dart | arithmetic, relational, logical, ternary, type tests | Theory demo |
| 04_control_flow.dart | if, switch (and switch expression), for, while, do-while, break/continue | Theory demo |
| 05_guided_lab_calculator.dart | console calculator with input validation | Guided lab |
| 06_guided_lab_grade_classifier.dart | grade classifier and summary | Guided lab |
| 07_lab_task_solution.dart | guessing game + temperature converter | Lab task solution |

## Session 2: Functions and collections (`session_02_functions_collections/`)
| File                         | Topic | Type |
|------------------------------| --- | --- |
| 01_functions.dart            | parameters (positional, optional, named), defaults, arrow, records, recursion | Theory demo |
| 02_collections.dart          | List, Set, Map, spread, collection if/for | Theory demo |
| 03_higher_order_methods.dart | map, where, reduce, fold, any, every, sort, chaining | Theory demo |
| 04_strings_and_errors.dart   | String methods, try/on/catch/finally, throw | Theory demo |
| 05_lab_task_grade_book.dart  | grade book with averages, top scorer, ranking | Lab task solution |

## Session 3: OOP part 1 (`session_03_oop_part1/`)
| File | Topic | Type |
| --- | --- | --- |
| 01_classes_and_objects.dart | classes, objects, fields, methods, `this`, references, cascade | Theory demo |
| 02_constructors.dart | default, parameterized, named, initializer list, redirecting, `const`, `factory` | Theory demo |
| 03_encapsulation.dart | private members, getters, setters, validation (imports the next file) | Theory demo |
| 03_encapsulation_speaker.dart | helper class for file 03 (private members are per file) | Helper |
| 04_static_tostring_equality.dart | `static`, `toString`, `==`, `hashCode`, operator overloading | Theory demo |
| 05_guided_lab_bank_and_student.dart | BankAccount and Student, built step by step | Guided lab |
| 06_lab_task_library_system.dart | Library system: description + solution | Lab task solution |

[//]: # ()
[//]: # (## Session 4: OOP part 2 &#40;`session_04_oop_part2/`&#41;)

[//]: # (| File | Topic | Type |)

[//]: # (| --- | --- | --- |)

[//]: # (| 01_inheritance_and_abstract.dart | `extends`, `super`, `@override`, abstract classes, `is`/`as` | Theory demo |)

[//]: # (| 02_interfaces_and_polymorphism.dart | `implements`, polymorphism, fake objects for testing | Theory demo |)

[//]: # (| 03_mixins_extensions_enums.dart | `mixin`/`with`/`on`, extension methods, enhanced enums | Theory demo |)

[//]: # (| 04_generics_and_async_preview.dart | generic classes and functions, bounded types, Future, Stream | Theory demo |)

[//]: # (| 05_guided_lab_shapes.dart | Shape hierarchy with a Printable mixin | Guided lab |)

[//]: # (| 06_lab_task_mini_ecommerce.dart | Mini e-commerce: description + solution | Lab task solution |)

## Practice tasks (`practice_tasks/`)
Extra tasks with description and solution for Sessions 1 and 2: cinema ticket booth and expense tracker.

## Teaching tip
- Files 05 to 07 of session 1 read input from the keyboard, so run them in a real terminal.
- Keep `03_encapsulation.dart` and `03_encapsulation_speaker.dart` in the same folder.
