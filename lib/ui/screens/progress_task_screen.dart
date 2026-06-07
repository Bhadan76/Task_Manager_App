import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/progress_task_screen.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_count_status_bar.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}


class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool getAllProgressInProgress = false;
  List<TaskModel> _progressList = [];
  @override
  void initState() {
    super.initState();
    _getAllProgressTasks();
  }

  Future<void> _getAllProgressTasks() async {
    getAllProgressInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Progress'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> JsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(JsonData));
      }
      _progressList = list;
    } else {
      Showsnackbarmessage(context, response.errorMassage!);
    }
    getAllProgressInProgress = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: getAllProgressInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
              itemBuilder: (context,index){
            return task_card_widget(
              text: 'Progress',
              taskModel: _progressList[index],
              refreshParent: () {
                _getAllProgressTasks();
              },
            );
          },
              separatorBuilder: (context,index){
                return SizedBox(height: 8,);

              },
              itemCount: _progressList.length,
          ),
        ),
      ),
    );
  }
}



