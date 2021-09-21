import 'package:flutter/material.dart';

class ToDoModel {
  final Key key;
  String title;
  bool checked;
  ToDoMode mode;

  ToDoModel({
    required this.key,
    this.title = '',
    this.checked = false,
    this.mode = ToDoMode.edit,
  });

  set newTitle(String newTitle) {
    title = newTitle;
  }

  set newMode(ToDoMode newMode) {
    mode = newMode;
  }

  set newChecked(bool newChecked) {
    checked = newChecked;
  }
}

enum ToDoMode { normal, edit }
