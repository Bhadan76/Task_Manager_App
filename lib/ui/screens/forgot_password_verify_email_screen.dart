import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_app/ui/screens/forgot_password_verify_OTP_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});
  static const String name = '/forgot-email-verify';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordEmailController _forgotPasswordEmailController = Get.find<ForgotPasswordEmailController>();

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digit verification pin will be sent to your email address',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String inputText = value ?? '';
                      if (EmailValidator.validate(inputText) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        GetBuilder<ForgotPasswordEmailController>(
                          builder: (controller) {
                            return Visibility(
                              visible: _forgotPasswordEmailController.forgotPwEmailInProgress == false,
                              replacement: const Center_progress_indegator(),
                              child: FilledButton(
                                onPressed: _onTapForgotPwVerifyEmail,
                                child: const Icon(Icons.arrow_circle_right),
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
                            text: "Have account? ",
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

  void _onTapForgotPwVerifyEmail() {
    if (_formkey.currentState!.validate()) {
      _forgotPwVerifyEmail();
    }
  }

  Future<void> _forgotPwVerifyEmail() async {
    final String email = _emailController.text.trim().toLowerCase();
    final bool isSuccess = await _forgotPasswordEmailController
        .forgotPwVerifyEmail(email);
    if (!mounted) return;

    if (isSuccess) {
      ShowSnackbarMessage(
        'Task Manager App',
        'OTP sent to $email. Check Inbox, Spam, and Promotions.',
      );
      Get.toNamed(ForgotPasswordVerifyOtpScreen.name, arguments: email);
      _emailController.clear();
    } else {
      ShowSnackbarMessage(
          'Task Manager App', _forgotPasswordEmailController.errorMessage!);
    }
  }

  void _onTapLoginButton() {
    Get.back();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
