import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class SignupController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {
   bool isSuccess = false;
   _inProgress = true;
   update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      _errorMessage= 'Registration success! please login';
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage= response.errorMassage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }


}