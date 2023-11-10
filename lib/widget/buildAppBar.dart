import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/colors.dart';

class BuildAppBar {
  // App Bar method calling it publicly
  AppBar buildAppBar() {
    return _buildAppBar();
  }
}

///App bar extracted method
AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: tdBgColor,
    leading: IconButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: () {},
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: Lottie.asset(
            'assets/profile.json',
          ),
        ),
      ),
    ],
  );
}
