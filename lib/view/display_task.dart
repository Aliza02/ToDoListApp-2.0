import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/model/task.dart';

import 'package:todolistapp/view/add_Task.dart';
import 'package:todolistapp/widget/list_item.dart';

import '../constants/colors.dart';
import '../widget/bottomNavBar.dart';
import '../controller/taskController.dart';

class displayTask extends StatefulWidget {
  const displayTask({super.key});

  @override
  State<displayTask> createState() => _displayTaskState();
}

class _displayTaskState extends State<displayTask> {
  final taskcontroller = Get.put(taskController());
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  List<Task> alltasks = [];
  bool fetching = true;
  void removeTask(int index) {
    // print("index $index");
    // print(taskcontroller.tasks);
    // print("length ${taskcontroller.tasks.length}");
    if (index == 0) {
      index = index;
    } else {
      --index;
    }

    DatabaseHelper.delete(taskcontroller.tasks[index].id);
    taskcontroller.tasks.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => list_item(
            animation: animation,
            index: index,
            taskName: taskcontroller.tasks[index].name,
            onRemove: () {}));

    // print("index $index");
    // print(taskcontroller.tasks);
    // print("length ${taskcontroller.tasks.length}");
  }

  void insertitem() {
    listKey.currentState!.insertItem(
      1,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    taskcontroller.tasks = await DatabaseHelper.queryAllRows();
    if (taskcontroller.tasks.isNotEmpty) {
      taskcontroller.fetching.value = false;
    } else {
      taskcontroller.fetching.value = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.off(() => add_Task());
            taskcontroller.fetching.value = true;
          },
          backgroundColor: AppColors.bluegrey,
          child: const Icon(Icons.add),
        ),
        backgroundColor: AppColors.lightblue,
        bottomNavigationBar: bottomNavBar(),
        body: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                margin: EdgeInsets.only(top: Get.height * 0.08),
                child: Text(
                  'To Do',
                  style: TextStyle(
                    fontSize: Get.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bluegrey,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: Get.width * 0.05,
                    color: Colors.grey,
                  ),
                ),
              ),
              Obx(
                () => !taskcontroller.fetching.value
                    ? Expanded(
                        child: SingleChildScrollView(
                          // clipBehavior: Clip.values[1],
                          scrollDirection: Axis.vertical,
                          child: AnimatedList(
                            key: listKey,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            initialItemCount: taskcontroller.tasks.length,
                            itemBuilder: (context, index, animation) {
                              return list_item(
                                  animation: animation,
                                  onRemove: () {
                                    print(index);
                                    removeTask(index);
                                    // print(taskcontroller.tasks.length);
                                    // taskcontroller.tasks.removeAt(index);
                                  },
                                  index: index,
                                  taskName: taskcontroller.tasks[index].name);
                            },
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: Get.height * 0.24),
                        child: Text(
                          'No Task to Display',
                          style: TextStyle(
                            fontSize: Get.width * 0.07,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
