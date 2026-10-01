// =============================================================
// Session 2 | Guided Lab: Console To-Do List Manager
// Skills practiced: List, Map, functions, higher-order methods,
//                   switch, input handling
// Run with:  dart run 06_guided_lab_todo_manager.dart
// =============================================================

import 'dart:io';

// Our "database": a list of tasks. Each task is a Map with the same keys.
// (In Session 3 we will replace these Maps with a proper Task class.)
final List<Map<String, dynamic>> tasks = [];
int nextId = 1; // used to give every task a unique id

void main() {
  // Pre-fill a few tasks so the menu has something to show.
  addTask('Read Dart documentation', priority: 'high');
  addTask('Finish Lab 1 task');
  addTask('Prepare for the quiz', priority: 'high');

  while (true) {
    printMenu();
    String? choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        showTasks(tasks);
        break;
      case '2':
        stdout.write('Task title: ');
        String title = (stdin.readLineSync() ?? '').trim();
        if (title.isEmpty) {
          print('Title cannot be empty.');
        } else {
          stdout.write('Priority (low / normal / high) [normal]: ');
          String p = (stdin.readLineSync() ?? '').trim().toLowerCase();
          addTask(title, priority: p.isEmpty ? 'normal' : p);
          print('Task added.');
        }
        break;
      case '3':
        int? doneId = askId('Id of the task to complete: ');
        print(doneId != null && markDone(doneId)
            ? 'Marked as done.'
            : 'Id not found.');
        break;
      case '4':
        int? deleteId = askId('Id of the task to delete: ');
        print(deleteId != null && removeTask(deleteId)
            ? 'Task deleted.'
            : 'Id not found.');
        break;
      case '5':
        print('\n-- Pending tasks --');
        showTasks(tasks.where((t) => t['done'] == false).toList());
        break;
      case '6':
        print('\n-- High priority tasks --');
        showTasks(tasks.where((t) => t['priority'] == 'high').toList());
        break;
      case '7':
        printStatistics();
        break;
      case '0':
      case null:
        print('Goodbye!');
        return;
      default:
        print('Invalid choice.');
    }
  }
}

// ---------------------------- Menu -----------------------------

void printMenu() {
  print('\n===== TO-DO MANAGER =====');
  print('1) Show all tasks');
  print('2) Add a task');
  print('3) Mark a task as done');
  print('4) Delete a task');
  print('5) Show pending tasks');
  print('6) Show high priority tasks');
  print('7) Statistics');
  print('0) Exit');
  stdout.write('Choose: ');
}

int? askId(String message) {
  stdout.write(message);
  return int.tryParse(stdin.readLineSync() ?? '');
}

// ------------------------- Task logic --------------------------

/// Adds a task. `priority` is a named parameter with a default value.
void addTask(String title, {String priority = 'normal'}) {
  tasks.add({
    'id': nextId,
    'title': title,
    'priority': priority,
    'done': false,
  });
  nextId++;
}

/// Returns true if a task with this id existed and was updated.
bool markDone(int id) {
  int index = tasks.indexWhere((t) => t['id'] == id);
  if (index == -1) return false;
  tasks[index]['done'] = true;
  return true;
}

/// Returns true if a task was removed.
bool removeTask(int id) {
  int before = tasks.length;
  tasks.removeWhere((t) => t['id'] == id);
  return tasks.length < before;
}

// --------------------------- Output ----------------------------

void showTasks(List<Map<String, dynamic>> list) {
  if (list.isEmpty) {
    print('(no tasks to show)');
    return;
  }
  for (var t in list) {
    String box = t['done'] == true ? '[x]' : '[ ]';
    print('${t['id'].toString().padLeft(2)} $box ${t['title']} '
        '(${t['priority']})');
  }
}

void printStatistics() {
  int total = tasks.length;
  int done = tasks.where((t) => t['done'] == true).length;
  double percent = total == 0 ? 0 : done / total * 100;

  // Count tasks per priority using a Map.
  Map<String, int> perPriority = {};
  for (var t in tasks) {
    String p = t['priority'] as String;
    perPriority[p] = (perPriority[p] ?? 0) + 1;
  }

  print('\n-- Statistics --');
  print('Total    : $total');
  print('Done     : $done (${percent.toStringAsFixed(0)}%)');
  print('Pending  : ${total - done}');
  print('Per priority: $perPriority');
}
