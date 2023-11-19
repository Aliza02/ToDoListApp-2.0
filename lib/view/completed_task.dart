import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/controller/taskController.dart';

class completedTask extends StatefulWidget {
  const completedTask({super.key});

  @override
  State<completedTask> createState() => _completedTaskState();
}

class _completedTaskState extends State<completedTask> {
  final taskcontroller = Get.put(taskController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
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
                child: Text(
                  'Completed!',
                  style: TextStyle(
                    fontSize: Get.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bluegrey,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskcontroller.completedTask.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: Get.height * 0.09,
                      margin: EdgeInsets.symmetric(
                        vertical: Get.width * 0.01,
                        horizontal: Get.width * 0.05,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            taskcontroller.completedTask[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.bluegrey,
                              fontSize: Get.width * 0.06,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
