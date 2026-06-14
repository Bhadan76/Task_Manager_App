import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>();
  @override
  void initState() {
    super.initState();
    _getAllCancelledTasks();
  }

  Future<void> _getAllCancelledTasks() async {
   bool isSuccess = await _cancelledTaskController.getAllCancelledTasks();
    if (!isSuccess) {
      ShowSnackbarMessage('Task Manager App', _cancelledTaskController.errorMessage!);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<CancelledTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getAllCancelledInProgress == false,
              replacement: Center_progress_indegator(),
              child: ListView.separated(
                  itemBuilder: (context,index){
                    return task_card_widget(
                  text: 'Cancelled',
                  taskModel:_cancelledTaskController.cancelledList[index],
                  refreshParent: () {
                    _getAllCancelledTasks();
                  },
                );
              },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);

                  },
                  itemCount: _cancelledTaskController.cancelledList.length,
              ),
            );
          }
        ),
      ),

    );
  }
}



