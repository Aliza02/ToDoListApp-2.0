import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:todolistapp/view/add_Task.dart';

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
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => add_Task(),
              transition: Transition.leftToRightWithFade,
            );
          },
          backgroundColor: AppColors.bluegrey,
          child: const Icon(Icons.add),
        ),
        backgroundColor: AppColors.lightblue,
        bottomNavigationBar: const bottomNavBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
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
                SingleChildScrollView(
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskcontroller.tasks.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              InkWell(
                                onTap: () {
                                  taskcontroller.addCompletedTask(
                                      taskcontroller.tasks[index]);
                                  taskcontroller.tasks.removeAt(index);
                                },
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.height * 0.08,
                                  decoration: const BoxDecoration(
                                    color: AppColors.bluegrey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.lightblue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  taskcontroller.tasks.removeAt(index);
                                },
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.height * 0.08,
                                  decoration: const BoxDecoration(
                                    color: AppColors.bluegrey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: AppColors.lightblue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            height: Get.height * 0.09,
                            margin: EdgeInsets.symmetric(
                              vertical: Get.width * 0.01,
                              horizontal: Get.width * 0.05,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  taskcontroller.tasks[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.bluegrey,
                                    fontSize: Get.width * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
