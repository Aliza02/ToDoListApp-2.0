import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/view/completed_task.dart';
import '../constants/colors.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({super.key});

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
            onPressed: () {
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
