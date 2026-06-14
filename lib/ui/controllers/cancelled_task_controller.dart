
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class CancelledTaskController extends GetxController{
  bool _getAllCancelledInProgress = false;
  bool get getAllCancelledInProgress => _getAllCancelledInProgress ;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _cancelledList = [];
  List<TaskModel> get cancelledList => _cancelledList;

  Future<bool> getAllCancelledTasks() async {
    bool isSuccess = false;

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.allTaskListUrl('Cancelled'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> JsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(JsonData));
      }
      _cancelledList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    _getAllCancelledInProgress = false;
    update();
    return isSuccess;
  }

}