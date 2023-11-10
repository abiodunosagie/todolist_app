import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:todolist_app/constant/colors.dart';
import 'package:todolist_app/widget/todo_items.dart';

import '../model/todo.dart';
import '../widget/buildAppBar.dart';
import '../widget/searchBox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //i called the todolist here using a variable.
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  void runFilterCallback(String enteredKeyword) {
    _runFilter(enteredKeyword);
  }

  @override
  void initState() {
    _foundToDo = todoList;
    // Prevent screenshots on Android
    ScreenProtector.protectDataLeakageOn();
    ScreenProtector.preventScreenshotOn();
    super.initState();
  }

  @override
  void dispose() {
    // Allow screenshots on Android
    //the dispose method is used to deactivate the screenshot prevention when the widget is no longer in use.
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
        appBar: appBar.buildAppBar(),
        //body
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
                            'All ToDos',
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
                    // An add button
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
                            fontSize: 40,
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
      todoList.removeWhere((item) => item.id == id);
    });
  }

  //function to handle the list change
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  //function to add items to the list
  void _addToDoItem(String toDo) {
    setState(
          () {
        todoList.add(
          ToDo(
            id: DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            todoText: toDo,
          ),
        );
      },
    );
    _todoController.clear();
  }


// the search function to search the Todo list
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
          item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
