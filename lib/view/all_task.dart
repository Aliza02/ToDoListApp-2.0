import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/view/display_task.dart';
import 'package:todolistapp/widget/card_text.dart';

class all_tasks extends StatefulWidget {
  const all_tasks({super.key});

  @override
  State<all_tasks> createState() => _all_tasksState();
}

class _all_tasksState extends State<all_tasks> {
  final taskcontroller = Get.put(taskController());
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    taskcontroller.allTasks = await DatabaseHelper.queryAllTasks();

    taskcontroller.fetching.value = false;
    listKey.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.off(
                () => const displayTask(),
                duration: const Duration(seconds: 1),
                transition: Transition.rightToLeftWithFade,
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                Get.width * 0.01,
                Get.height * 0.03,
                0.0,
                0.0,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.bluegrey,
                size: Get.width * 0.09,
              ),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: AppColors.lightblue,
        body: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                margin: EdgeInsets.only(top: Get.height * 0.08),
                child: Text(
                  'All Tasks!',
                  style: TextStyle(
                    fontSize: Get.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bluegrey,
                  ),
                ),
              ),
              Obx(
                () => taskcontroller.fetching.value == false
                    ? Expanded(
                        child: taskcontroller.allTasks.isNotEmpty
                            ? AnimatedList(
                                key: listKey,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                initialItemCount:
                                    taskcontroller.allTasks.length,
                                itemBuilder: (context, index, animation) {
                                  return Container(
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
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 191, 200, 221),
                                            blurRadius: 3.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          card_text(
                                            cardText: taskcontroller
                                                .allTasks[index].name,
                                            fontSize: Get.width * 0.06,
                                          ),
                                          Text(
                                            taskcontroller
                                                .allTasks[index].status,
                                            style: TextStyle(
                                              color: taskcontroller
                                                          .allTasks[index]
                                                          .status ==
                                                      'pending'
                                                  ? Colors.green
                                                  : AppColors.bluegrey,
                                              fontSize: Get.width * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.bluegrey,
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
