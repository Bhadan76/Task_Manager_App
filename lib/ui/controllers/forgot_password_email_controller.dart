
import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
class ForgotPasswordEmailController extends GetxController {
  bool _forgotPwEmailInProgress = false;
  bool get forgotPwEmailInProgress => _forgotPwEmailInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? recoveryEmail;

  Future<bool> forgotPwVerifyEmail(String email) async {
    final String normalizedEmail = email.trim().toLowerCase();
    _forgotPwEmailInProgress = true;
    _errorMessage = null;
    update();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.forgotPasswordEmailVerifyUrl(normalizedEmail),
    );

    bool isSuccess = false;
    if (response.isSuccess &&
        response.responseData != null &&
        response.responseData['status'] == 'success') {
      recoveryEmail = normalizedEmail;
      isSuccess = true;
      _errorMessage = null;
    } else {
      recoveryEmail = null;
      _errorMessage = _readErrorMessage(response, 'Failed to send OTP');
    }

    _forgotPwEmailInProgress = false;
    update();
    return isSuccess;
  }

  String _readErrorMessage(ApiResponse response, String fallback) {
    if (response.responseData != null && response.responseData['data'] != null) {
      return response.responseData['data'].toString();
    }
    return response.errorMassage ?? fallback;
  }
}
