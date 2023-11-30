import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/task.dart';

class taskController extends GetxController {
  List toDotasks = <Task>[].obs;
  List completedTask = <Task>[].obs;
  List allTasks = <Task>[].obs;

  RxBool fetching = true.obs;
  RxBool onRemove = false.obs;
  RxBool onComplete = false.obs;

  final TextEditingController taskTitle = TextEditingController();

  void addTask(Task newTask) {
    toDotasks.add(newTask);
  }

  void addCompletedTask(Task completedtask) {
    completedTask.add(completedtask);
  }
}
