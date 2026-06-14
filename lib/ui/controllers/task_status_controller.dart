
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_status_count_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class TaskStatusController extends GetxController {
  bool _getStatusInProgress = false;
  bool get getInProgress => _getStatusInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getAllTaskStatusNewTasks() async {
    bool isSuccess = false;
    _getStatusInProgress = true;
    update();
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.formJson(jsonData));
      }
      _taskStatusCountList = list;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _getStatusInProgress = false;
    update();
    return isSuccess;
  }
}