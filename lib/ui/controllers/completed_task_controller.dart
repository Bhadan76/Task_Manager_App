
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class CompletedTaskController extends GetxController{
  bool _getAllCompletedInProgress = false;
  bool get getAllCompletedInProgress => _getAllCompletedInProgress ;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _completedList = [];
  List<TaskModel> get completedList => _completedList;

  Future<bool> getAllCompletedTasks() async {
    bool isSuccess = false;

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Completed'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    _getAllCompletedInProgress = false;
    update();
    return isSuccess;
  }

}