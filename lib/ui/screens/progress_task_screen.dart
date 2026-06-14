import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}


class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();
  @override
  void initState() {
    super.initState();
    _getAllProgressTasks();
  }

  Future<void> _getAllProgressTasks() async {
    bool isSuccess = await _progressTaskController.getAllProgressTasks();
    if (!isSuccess) {
      ShowSnackbarMessage('Task Manager App', _progressTaskController.errorMessage!);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<ProgressTaskController>(
          builder: (controller) {
            return Visibility(
              visible:controller.getAllProgressInProgress  == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.separated(
                  itemBuilder: (context,index){
                return task_card_widget(
                  text: 'Progress',
                  taskModel: _progressTaskController.progressList[index],
                  refreshParent: () {
                    _getAllProgressTasks();
                  },
                );
              },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);

                  },
                  itemCount: _progressTaskController.progressList.length,
              ),
            );
          }
        ),
      ),
    );
  }
}



