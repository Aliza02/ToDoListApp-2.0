import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todolistapp/view/taskList.dart';

import '../constants/colors.dart';
import '../widget/bottomNavBar.dart';
import '../controller/taskController.dart';

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  final taskcontroller = Get.put(taskController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => taskList(),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.bluegrey,
        ),
        backgroundColor: AppColors.lightblue,
        bottomNavigationBar: const bottomNavBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  margin: EdgeInsets.only(top: height * 0.08),
                  child: Text(
                    'To Do',
                    style: TextStyle(
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.bold,
                      color: AppColors.bluegrey,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  child: Text(
                    "Today's Tasks",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.grey,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: taskcontroller.tasks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: height * 0.08,
                          margin: EdgeInsets.symmetric(
                              vertical: width * 0.01, horizontal: width * 0.03),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                taskcontroller.tasks[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.bluegrey,
                                  fontSize: width * 0.05,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Container(
                //   width: width * 0.8,
                //   height: height * 0.07,
                //   child: Card(
                //     child: Text('sdada'),
                //   ),
                // ),
                // Container(
                //   width: width * 0.8,
                //   padding: EdgeInsets.symmetric(vertical: width * 0.01),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       hintText: 'Enter Task Name',
                //       hintStyle: TextStyle(
                //         color: Colors.blueGrey[900],
                //         fontSize: width * 0.05,
                //       ),
                //       fillColor: Color(0xFF43516C).withOpacity(0.6),
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   width: width * 0.8,
                //   padding: EdgeInsets.symmetric(vertical: width * 0.06),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       hintText: 'Enter Task Name',
                //       hintStyle: TextStyle(
                //         color: Colors.blueGrey[900],
                //         fontSize: width * 0.05,
                //       ),
                //       fillColor: Colors.yellow[50],
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   width: width * 0.5,
                //   height: height * 0.07,
                //   child: ElevatedButton.icon(
                //     onPressed: () {},
                //     icon: Icon(Icons.add),
                //     label: Text(
                //       'Add',
                //       style: TextStyle(
                //         color: Color(0xFFE5E8C7),
                //         fontSize: width * 0.05,
                //       ),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF43516C),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
