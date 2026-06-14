import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _newTaskInProgress = false;
  bool get newTaskInProgress => _newTaskInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> addNewTasks(String tittle, String description) async {
    bool isSuccess = false;
    _newTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody ={
      "title":tittle,
      "description":description,
      "status":"New"
    };
    ApiResponse response= await ApiCaller.postRequest(url: Urls.createTaskUrl,body: requestBody);

    if(response.isSuccess){
        _errorMessage ='New task added';
        Get.back(result: true);

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _newTaskInProgress = false;
    update();
    return isSuccess;
  }
}