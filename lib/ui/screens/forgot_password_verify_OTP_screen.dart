import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_otp_controller.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/new_password_set_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  static const String name = '/forgot-password-verify-otp';

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final ForgotPasswordOtpController _forgotPasswordOtpController =
      Get.find<ForgotPasswordOtpController>();

  String get _email {
    final String? routeEmail = Get.arguments as String?;
    if (routeEmail != null && routeEmail.isNotEmpty) {
      return routeEmail;
    }
    return Get.find<ForgotPasswordEmailController>().recoveryEmail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Enter Your OTP',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digit verification pin has been sent to $_email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check Inbox, Spam, and Promotions. Search Gmail for "teamrabbil" or "info@teamrabbil.com".',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 35),
                  PinCodeTextField(
                    length: 6,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.green,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _otpController,
                    appContext: context,
                    onCompleted: _forgotOtpVerify,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _resendOtp,
                    child: const Text('Resend OTP'),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        GetBuilder<ForgotPasswordOtpController>(
                          builder: (controller) {
                            return Visibility(
                              visible: controller.forgotPasswordOtpInProgress == false,
                              replacement: const Center_progress_indegator(),
                              child: FilledButton(
                                onPressed: _verifyOtp,
                                child: const Text('Verify'),
                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 40),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapLoginButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp() {
    _forgotOtpVerify(_otpController.text.trim());
  }

  Future<void> _resendOtp() async {
    if (_email.isEmpty) {
      ShowSnackbarMessage('Task Manager App', 'Email is missing. Please go back and try again.');
      return;
    }

    final bool isSuccess = await Get.find<ForgotPasswordEmailController>()
        .forgotPwVerifyEmail(_email);

    if (!mounted) return;

    if (isSuccess) {
      ShowSnackbarMessage('Task Manager App', 'A new OTP has been sent to $_email');
      _otpController.clear();
    } else {
      ShowSnackbarMessage(
        'Task Manager App',
        Get.find<ForgotPasswordEmailController>().errorMessage ??
            'Failed to resend OTP',
      );
    }
  }

  Future<void> _forgotOtpVerify(String otp) async {
    if (otp.length != 6) {
      ShowSnackbarMessage('Task Manager App', 'Enter 6 digit OTP');
      return;
    }

    final bool isSuccess = await _forgotPasswordOtpController.forgotPasswordOtp(
      _email,
      otp,
    );

    if (!mounted) return;

    if (isSuccess) {
      Get.toNamed(
        NewPasswordSetScreen.name,
        arguments: {'email': _email, 'otp': otp},
      );
    } else {
      ShowSnackbarMessage(
        'Task Manager App',
        _forgotPasswordOtpController.errorMessage ?? 'Invalid OTP',
      );
    }
  }

  void _onTapLoginButton() {
    Get.offAllNamed(LoginScreen.name, predicate: (route) => false);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
