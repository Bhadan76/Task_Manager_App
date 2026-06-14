import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getStatusInProgress = false;
  bool get getInProgress => _getStatusInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getAllNewTasks() async {
    bool isSuccess = false;
    _getStatusInProgress = true;
    update();
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('New'),
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
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