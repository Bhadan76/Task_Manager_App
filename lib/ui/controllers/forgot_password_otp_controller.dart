import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';

class ForgotPasswordOtpController extends GetxController {
  bool _forgotPasswordOtpInProgress = false;
  bool get forgotPasswordOtpInProgress => _forgotPasswordOtpInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> forgotPasswordOtp(String email, String otp) async {
    final String normalizedEmail = email.trim().toLowerCase();
    final String normalizedOtp = otp.trim();

    if (normalizedEmail.isEmpty) {
      _errorMessage = 'Email is missing. Please go back and try again.';
      update();
      return false;
    }

    if (normalizedOtp.length != 6) {
      _errorMessage = 'Enter 6 digit OTP';
      update();
      return false;
    }

    _forgotPasswordOtpInProgress = true;
    _errorMessage = null;
    update();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.forgotPasswordOtpVerifyUrl(normalizedEmail, normalizedOtp),
    );

    bool isSuccess = false;
    if (response.isSuccess &&
        response.responseData != null &&
        response.responseData['status'] == 'success') {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = _readErrorMessage(response, 'Invalid OTP');
    }

    _forgotPasswordOtpInProgress = false;
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
