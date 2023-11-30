import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/widget/item_card.dart';

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

                if (taskcontroller.toDotasks.isEmpty) {
                  // taskcontroller.fetching.value = true;
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
        child: item_card(
          animation: widget.animation,
          fontSize: Get.width * 0.06,
          cardText: widget.taskName,
        ),
      ),
    );
  }
}
