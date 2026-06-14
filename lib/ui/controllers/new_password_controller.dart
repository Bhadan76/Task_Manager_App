import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class NewPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    final String normalizedEmail = email.trim().toLowerCase();
    final String normalizedOtp = otp.trim();

    if (normalizedEmail.isEmpty || normalizedOtp.isEmpty) {
      _errorMessage =
          'Invalid request. Please try again from the beginning.';
      update();
      return false;
    }

    _resetPasswordInProgress = true;
    _errorMessage = null;
    update();

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.RecoverResetPassUrl,
      body: {
        'email': normalizedEmail,
        'OTP': normalizedOtp,
        'password': password,
      },
    );

    bool isSuccess = false;
    if (response.isSuccess &&
        response.responseData != null &&
        response.responseData['status'] == 'success') {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = _readErrorMessage(response, 'Failed to reset password');
    }

    _resetPasswordInProgress = false;
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
