import 'package:flutter/material.dart';
import 'package:teknofest_todo_app_demo/screens/to_do_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do App',
      home: ToDoScreen(),
    );
  }
}
