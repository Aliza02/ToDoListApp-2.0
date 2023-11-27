import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todolistapp/database/database_helper.dart';
import 'package:todolistapp/view/display_task.dart';

import '../constants/colors.dart';
import '../controller/taskController.dart';

class add_Task extends StatelessWidget {
  add_Task({super.key});
  final taskcontroller = Get.put(taskController());
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightblue,
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: width,
                height: height * 0.1,
                child: TextFormField(
                  controller: taskcontroller.taskTitle,
                  textAlign: TextAlign.center,
                  cursorColor: AppColors.bluegrey,
                  cursorHeight: 40.0,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: width * 0.08,
                    decoration: TextDecoration.none,
                    color: AppColors.bluegrey,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Add Task',
                    hintStyle: TextStyle(
                      fontSize: width * 0.08,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: width * 0.4,
                height: height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bluegrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    shadowColor: Colors.grey,
                  ),
                  onPressed: () async {
                    // DatabaseHelper.insert;
                    Map<String, String> row = {
                      DatabaseHelper.task: taskcontroller.taskTitle.text,
                      DatabaseHelper.status: 'pending'
                    };

                    final id = await dbHelper.insert(row);

                    // taskcontroller.addTask(
                    //   Task(taskcontroller.taskTitle.text,id,'pending'),
                    // );
                    taskcontroller.taskTitle.clear();
                  
                  
                  
                    

                    Get.off(() => displayTask());
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Add to List',
                    style: TextStyle(
                      fontSize: width * 0.04,
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
