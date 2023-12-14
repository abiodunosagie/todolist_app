import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:todolist_app/constant/colors.dart';
import 'package:todolist_app/widget/todo_items.dart';

import '../model/todo.dart';
import '../state/todolist_model.dart';
import '../widget/buildAppBar.dart';
import '../widget/searchBox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ToDo> _foundToDo;
  final _todoController = TextEditingController();

  void runFilterCallback(String enteredKeyword) {
    _runFilter(enteredKeyword);
  }

  @override
  void didChangeDependencies() {
    _foundToDo = Provider.of<ToDoListModel>(context).todos;
    ScreenProtector.protectDataLeakageOn();
    ScreenProtector.preventScreenshotOn();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ScreenProtector.protectDataLeakageOff();
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BuildAppBar appBar = BuildAppBar();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: tdBgColor,
        appBar: appBar.buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: searchBox(runFilterCallback),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: const Text(
                            'ToDos',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todoo in _foundToDo)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(0.4, 4),
                              blurRadius: 10.0,
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: const InputDecoration(
                            hintText: 'Add a new todo item',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                3,
                              ),
                            ),
                          ),
                          backgroundColor: tdBlue,
                          minimumSize: const Size(
                            60,
                            60,
                          ),
                          elevation: 10,
                        ),
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteToDoItem(String id) {
    setState(() {
      _foundToDo.removeWhere((item) => item.id == id);
    });
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      _foundToDo.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = Provider.of<ToDoListModel>(context).todos;
    } else {
      results = Provider.of<ToDoListModel>(context)
          .todos
          .where(
            (item) => item.todoText.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
