import 'package:flutter/material.dart';

import '../constant/colors.dart';

Container searchBox(Function(String) filterCallback) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        20,
      ),
    ),
    child: TextField(
      onChanged: (value) => filterCallback(value),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(
          0,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: tdBlack,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20,
          minWidth: 25,
        ),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: tdGrey),
      ),
    ),
  );
}
