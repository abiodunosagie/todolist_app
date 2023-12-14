import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/todolist_model.dart';

class TotalTodos extends StatelessWidget {
  const TotalTodos({super.key});

  @override
  Widget build(BuildContext context) {
    int totalTodos = Provider.of<ToDoListModel>(context).todos.length;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Your total todo is $totalTodos',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
