import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String id;

  @HiveField(1)
  String todoText;

  @HiveField(2)
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  ///List items for the todo items
  static List<ToDo> todoList() {
    return [];
  }

  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }
}
