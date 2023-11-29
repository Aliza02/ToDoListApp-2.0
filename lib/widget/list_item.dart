import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';

class list_item extends StatefulWidget {
  final String taskName;
  final Function onRemove;
  final int index;
  final Animation<double> animation;
  const list_item(
      {super.key,
      required this.animation,
      required this.taskName,
      required this.onRemove,
      required this.index});

  @override
  State<list_item> createState() => _list_itemState();
}

class _list_itemState extends State<list_item> {
  final taskcontroller = Get.put(taskController());

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            InkWell(
              onTap: () {
                taskcontroller.onComplete.value = true;
                widget.onRemove();
                // taskcontroller.addCompletedTask(taskcontroller.tasks[index]);
                // taskcontroller.tasks.removeAt(index);
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
                // taskcontroller.tasks.removeAt(widget.index);
                taskcontroller.onRemove.value = true;
                widget.onRemove();

                if (taskcontroller.tasks.isEmpty) {
                  taskcontroller.fetching.value = true;
                }
                // print(taskcontroller.tasks.length);
                // print(widget.index);
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
          // height: Get.height * 0.09,
          width: Get.width * 0.9,
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.01,
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
                  color: Color.fromARGB(255, 191, 200, 221),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0),
                ),
              ]),
          child: Text(
            widget.taskName,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              color: AppColors.bluegrey,
              fontSize: Get.width * 0.06,
            ),
          ),
        ),
      ),
    );
  }
}
