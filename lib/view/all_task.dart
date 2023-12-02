import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/view/display_task.dart';
import 'package:todolistapp/widget/card_text.dart';
import 'package:todolistapp/widget/heading.dart';
import 'package:todolistapp/widget/item_card.dart';

class all_tasks extends StatefulWidget {
  const all_tasks({super.key});

  @override
  State<all_tasks> createState() => _all_tasksState();
}

class _all_tasksState extends State<all_tasks> {
  final taskcontroller = Get.put(taskController());
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // taskcontroller.fetching.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() async {
    taskcontroller.allTasks = await DatabaseHelper.queryAllTasks();
    taskcontroller.allTasks.forEach((element) {
      int index = 0;

      listKey.currentState!.insertItem(index);
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              taskcontroller.toDotasks.clear();
              taskcontroller.allTasks.clear();
              taskcontroller.fetching.value = false;
              Get.off(
                () => const displayTask(),
                duration: const Duration(milliseconds: 800),
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
                  child: const heading(
                    pageTitle: 'All Tasks!',
                  )),
              Obx(
                () => taskcontroller.fetching.value == false
                    ? Expanded(
                        child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AnimatedList(
                          key: listKey,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: taskcontroller.allTasks.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child: Container(
                                width: Get.width * 0.9,
                                padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02,
                                  horizontal: Get.width * 0.03,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.width * 0.02,
                                  horizontal: Get.width * 0.05,
                                ),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 191, 200, 221),
                                        blurRadius: 3.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(2.0, 2.0),
                                      ),
                                    ]),
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: card_text(
                                        cardText:
                                            taskcontroller.allTasks[index].name,
                                        fontSize: Get.width * 0.06,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: Get.height * 0.01,
                                          width: Get.width * 0.02,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: taskcontroller
                                                        .allTasks[index]
                                                        .status ==
                                                    'pending'
                                                ? Colors.green
                                                : AppColors.bluegrey,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        Text(
                                          taskcontroller.allTasks[index].status,
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
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ))
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
