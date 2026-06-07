import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/models/task_status_count_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_count_status_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const String name = '/New task screen';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getAllTaskStatusInProgress = false;
  bool getAllNewTasksInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

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
    getAllTaskStatusInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> JsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.formJson(JsonData));
      }
      _taskStatusCountList = list;
    } else {
      Showsnackbarmessage(context, response.errorMassage!);
    }
    getAllTaskStatusInProgress = false;
    setState(() {});
  }

  Future<void> getAllNewTasks() async {
    getAllNewTasksInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('New'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> JsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(JsonData));
      }
      _newTaskList = list;
    } else {
      Showsnackbarmessage(context, response.errorMassage!);
    }
    getAllNewTasksInProgress = false;
    setState(() {});
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
              height: 90,
              child: Visibility(
                visible: getAllTaskStatusInProgress == false,
                replacement: Center_progress_indegator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return taskCountStatusBar(tittle: _taskStatusCountList[index].status, count:  _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20);
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getAllNewTasksInProgress == false,
                replacement: Center_progress_indegator(),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return task_card_widget(
                      text: 'New',
                      taskModel: _newTaskList[index],
                      refreshParent: () {
                        getAllNewTasks();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                  itemCount: _newTaskList.length,
                ),
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
