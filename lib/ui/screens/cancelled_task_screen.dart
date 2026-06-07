import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/progress_task_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_count_status_bar.dart';
class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getAllCancelledInProgress = false;
  List<TaskModel> _cancelledList = [];
  @override
  void initState() {
    super.initState();
    _getAllCancelledTasks();
  }

  Future<void> _getAllCancelledTasks() async {
    _getAllCancelledInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Cancelled'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledList = list;
    } else {
      Showsnackbarmessage(context, response.errorMassage!);
    }
    _getAllCancelledInProgress = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _getAllCancelledInProgress == false,
          replacement: Center_progress_indegator(),
          child: ListView.separated(
              itemBuilder: (context,index){
                return task_card_widget(
              text: 'Cancelled',
              taskModel: _cancelledList[index],
              refreshParent: () {
                _getAllCancelledTasks();
              },
            );
          },
              separatorBuilder: (context,index){
                return SizedBox(height: 8,);

              },
              itemCount: _cancelledList.length,
          ),
        ),
      ),

    );
  }
}



