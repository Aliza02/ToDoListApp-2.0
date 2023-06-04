import 'package:flutter/material.dart';

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
              Icons.edit,
              color: AppColors.lightblue,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.circle,
              color: AppColors.lightblue,
            ),
          ),
        ],
      ),
    );
  }
}
