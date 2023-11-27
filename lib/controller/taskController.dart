import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/task.dart';

class taskController extends GetxController {
  List tasks = <Task>[].obs;
  List completedTask = <Task>[].obs;
  RxBool fetching = true.obs;

  final TextEditingController taskTitle = TextEditingController();

  void addTask(Task newTask) {
    tasks.add(newTask);
  }

  void addCompletedTask(Task completedtask) {
    completedTask.add(completedtask);
  }
}
