
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class ProgressTaskController extends GetxController{
  bool _getAllProgressInProgress = false;
  bool get getAllProgressInProgress => _getAllProgressInProgress ;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _progressList = [];
  List<TaskModel> get progressList => _progressList;

  Future<bool> getAllProgressTasks() async {
    bool isSuccess = false;

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Progress'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> JsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(JsonData));
      }
      _progressList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    _getAllProgressInProgress = false;
    update();
    return isSuccess;
  }

}