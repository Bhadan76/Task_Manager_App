import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getAllCompletedInProgress = false;
  List<TaskModel> _completedList = [];
  @override
  void initState() {
    super.initState();
    _getAllCompletedTasks();
  }
  Future<void> _getAllCompletedTasks() async {
    _getAllCompletedInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Completed'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedList = list;
    } else {
      Showsnackbarmessage(context, response.errorMassage!);
    }
    _getAllCompletedInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _getAllCompletedInProgress == false,
          replacement: Center_progress_indegator(),
          child: ListView.separated(
              itemBuilder: (context,index){
            return task_card_widget(
              text: 'Completed',
              taskModel: _completedList[index],
              refreshParent: () {
                _getAllCompletedTasks();
              },
            );
          },
              separatorBuilder: (context,index){
                return SizedBox(height: 8,);

              },
              itemCount: _completedList.length,
          ),
        ),
      ),
    );
  }
}



