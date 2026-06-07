import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/new_password_set_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  static const String name = '/forgot password verify OTP';

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _verifyOtpInProgress = false;

  @override
  Widget build(BuildContext context) {
    final String email =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

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
                    'A 6 digit verification pin has been sent to $email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
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
                    onCompleted: (v) {
                      _verifyOtp(email);
                    },
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Visibility(
                          visible: _verifyOtpInProgress == false,
                          replacement: const Center_progress_indegator(),
                          child: FilledButton(
                            onPressed: () => _verifyOtp(email),
                            child: const Text('Verify'),
                          ),
                        ),
                        const SizedBox(height: 40),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
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

  void _verifyOtp(String email) async {
    if (_otpController.text.length != 6) {
      Showsnackbarmessage(context, 'Enter 6 digit OTP');
      return;
    }
    _forgotOtpVerify(email);
  }

  Future<void> _forgotOtpVerify(String email) async {
    _verifyOtpInProgress = true;
    setState(() {});

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.forgotPasswordOtpVerifyUrl(email, _otpController.text),
    );

    _verifyOtpInProgress = false;
    setState(() {});

    if (response.isSuccess && response.responseData['status'] == 'success') {
      if (mounted) {
        Showsnackbarmessage(context, 'OTP verified successfully');
        Get.toNamed(
          NewPasswordSetScreen.name,
          arguments: {'email': email, 'otp': _otpController.text},
        );
      }
    } else {
      if (mounted) {
        String errorMsg = response.errorMassage ?? 'Invalid OTP';
        if (response.responseData != null && response.responseData['data'] != null) {
          errorMsg = response.responseData['data'];
        }
        Showsnackbarmessage(context, errorMsg);
      }
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
