import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/ui/controllers/new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/task_status_controller.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_count_status_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const String name = '/New task screen';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final TaskStatusController _taskStatusController = Get.find<TaskStatusController>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    getAllTaskStatusCount();
    getAllNewTasks();
  }

  Future<void> getAllTaskStatusCount() async {
    bool isSuccess = await _taskStatusController.getAllTaskStatusNewTasks();

    if (!isSuccess) {
      ShowSnackbarMessage('Task Manager App', _taskStatusController.errorMessage!);
    }
  }

  Future<void> getAllNewTasks() async {
    bool isSuccess= await _newTaskController. getAllNewTasks();
    if (!isSuccess) {
      ShowSnackbarMessage('Task Manager App',_newTaskController.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: Get.height * 0.1,
              child: GetBuilder<TaskStatusController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getInProgress == false,
                    replacement: Center_progress_indegator(),
                    child: ListView.separated(
                      itemCount: _taskStatusController.taskStatusCountList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return taskCountStatusBar(tittle: _taskStatusController.taskStatusCountList[index].status, count:  _taskStatusController.taskStatusCountList[index].count);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 20);
                      },
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getInProgress == false,
                    replacement: Center_progress_indegator(),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return task_card_widget(
                          text: 'New',
                          taskModel:_newTaskController.newTaskList[index],
                          refreshParent: () {
                            getAllNewTasks();
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                      itemCount: _newTaskController.newTaskList.length,
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddTaskScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddTaskScreen() {
    Get.toNamed(AddNewTaskScreen.name);
  }
}


