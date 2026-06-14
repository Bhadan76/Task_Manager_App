import 'package:get/get.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';

class SigninController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    bool isSuccess =false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel model = UserModel.formJson(response.responseData['data']);
      String accessToken = response.responseData['token'];
      await Authcontroller.saveUserData(model, accessToken);
      isSuccess = true;
      _errorMessage = null;
    } else {
      if(response.responseCode == 401){
        _errorMessage= 'Username/password is incorrect';
      }else{
        _errorMessage=response.errorMassage;
      }
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}