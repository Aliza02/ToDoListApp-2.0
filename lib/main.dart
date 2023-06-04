import 'package:flutter/material.dart';
import 'package:todolistapp/view/addTask.dart';
import 'package:todolistapp/view/taskList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: addTask(),
      // SafeArea(
      //   child: Scaffold(
      //     body: Text('Hello World'),
      //   ),
      // ),
    );
  }
}
