import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';

class heading extends StatelessWidget {
  final String pageTitle;
  const heading({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      pageTitle,
      style: TextStyle(
        fontSize: Get.width * 0.1,
        fontWeight: FontWeight.bold,
        color: AppColors.bluegrey,
      ),
    );
  }
}
