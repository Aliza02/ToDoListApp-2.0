import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/widget/item_card.dart';
import 'package:todolistapp/widget/slidable_buttons.dart';

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
        groupTag: widget.index,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            InkWell(
              onTap: () {
                taskcontroller.onComplete.value = true;
                widget.onRemove();
                if (taskcontroller.toDotasks.isEmpty) {
                  taskcontroller.fetching.value = true;
                }

                taskcontroller.onComplete.value = false;
              },
              child: const slidableButtons(icon: Icons.check),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            InkWell(
              onTap: () {
                taskcontroller.onRemove.value = true;
                widget.onRemove();
                if (taskcontroller.toDotasks.isEmpty) {
                  taskcontroller.fetching.value = true;
                }
                taskcontroller.onRemove.value = false;
              },
              child: const slidableButtons(icon: Icons.delete),
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
