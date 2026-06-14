import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
 final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();
  @override
  void initState() {
    super.initState();
    _getAllCompletedTasks();
  }
  Future<void> _getAllCompletedTasks() async {
    bool isSuccess = await _completedTaskController.getAllCompletedTasks();
    if (!isSuccess) {
      ShowSnackbarMessage('Task Manager App', _completedTaskController.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<CompletedTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getAllCompletedInProgress == false,
              replacement: Center_progress_indegator(),
              child: ListView.separated(
                  itemBuilder: (context,index){
                return task_card_widget(
                  text: 'Completed',
                  taskModel: _completedTaskController.completedList[index],
                  refreshParent: () {
                    _getAllCompletedTasks();
                  },
                );
              },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);

                  },
                  itemCount: _completedTaskController.completedList.length,
              ),
            );
          }
        ),
      ),
    );
  }
}



