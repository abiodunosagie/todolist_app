import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist_app/screens/total_todos.dart';

import '../constant/colors.dart';

class BuildAppBar {
  // App Bar method calling it publicly
  AppBar buildAppBar(BuildContext context) {
    return _buildAppBar(context);
  }
}

/// App bar extracted method
AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: tdBgColor,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TotalTodos()));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Lottie.asset(
              'assets/profile.json',
            ),
          ),
        ),
      ),
    ],
  );
}
