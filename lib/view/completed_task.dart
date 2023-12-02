import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/view/display_task.dart';
import 'package:todolistapp/widget/heading.dart';
import 'package:todolistapp/widget/item_card.dart';
import 'package:todolistapp/widget/slidable_buttons.dart';

class completedTask extends StatefulWidget {
  const completedTask({super.key});

  @override
  State<completedTask> createState() => _completedTaskState();
}

class _completedTaskState extends State<completedTask> {
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
    taskcontroller.completedTask = await DatabaseHelper.queryOnCompleteTask();
    if (taskcontroller.completedTask.isEmpty) {
      taskcontroller.fetching.value = true;
    }
    taskcontroller.completedTask.forEach((element) {
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
              taskcontroller.completedTask.clear();
              taskcontroller.fetching.value = false;
              Get.off(
                () => const displayTask(),
                duration: const Duration(milliseconds: 800),
                transition: Transition.leftToRightWithFade,
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
                child: const heading(pageTitle: 'Completed'),
              ),
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
                            initialItemCount:
                                taskcontroller.completedTask.length,
                            itemBuilder: (context, index, animation) {
                              return Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          String removeItem = taskcontroller
                                              .completedTask[index].name;
                                          DatabaseHelper.delete(taskcontroller
                                              .completedTask[index].id);
                                          taskcontroller.completedTask
                                              .removeAt(index);
                                          listKey.currentState!.removeItem(
                                              index,
                                              (context, animation) => item_card(
                                                  cardText: removeItem,
                                                  fontSize: Get.width * 0.06,
                                                  animation: animation));

                                          if (taskcontroller
                                              .completedTask.isEmpty) {
                                            taskcontroller.fetching.value =
                                                true;
                                          }
                                        },
                                        child: const slidableButtons(
                                            icon: Icons.delete),
                                      ),
                                    ]),
                                child: item_card(
                                  animation: animation,
                                  cardText:
                                      taskcontroller.completedTask[index].name,
                                  fontSize: Get.width * 0.06,
                                ),
                              );
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
