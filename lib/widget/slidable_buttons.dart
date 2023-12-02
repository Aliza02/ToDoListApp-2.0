import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class slidableButtons extends StatelessWidget {
  final IconData icon;
  const slidableButtons({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.15,
      height: Get.height * 0.08,
      decoration: const BoxDecoration(
        color: AppColors.bluegrey,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Icon(
        icon,
        color: AppColors.lightblue,
      ),
    );
  }
}
