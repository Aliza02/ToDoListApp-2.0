import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controller/taskController.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/view/completed_task.dart';
import '../constants/colors.dart';

class bottomNavBar extends StatelessWidget {
  bottomNavBar({super.key});
  final taskcontroller = Get.put(taskController());

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5.0,
      shape: const CircularNotchedRectangle(),
      color: AppColors.bluegrey,
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.list,
              color: AppColors.lightblue,
            ),
            onPressed: () async {
              Get.to(() => completedTask());
              
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.checklist_outlined,
              color: AppColors.lightblue,
            ),
          ),
        ],
      ),
    );
  }
}
