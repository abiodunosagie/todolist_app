import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class ToDoListModel extends ChangeNotifier {
  List<ToDo> _todos = ToDo.todoList();
  List<ToDo> _foundToDo = []; // Add this line

  List<ToDo> get todos => _todos;

  // ... other methods

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = _todos;
    } else {
      results = _todos
          .where(
            (item) => item.todoText.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    _foundToDo = results;
    notifyListeners();
  }
}
