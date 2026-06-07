import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';

class NewPasswordSetScreen extends StatefulWidget {
  const NewPasswordSetScreen({super.key});

  static const String name = '/New password set screen';

  @override
  State<NewPasswordSetScreen> createState() => _NewPasswordSetScreenState();
}

class _NewPasswordSetScreenState extends State<NewPasswordSetScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController =
      TextEditingController();
  bool _resetPasswordInProgress = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String email = args?['email'] ?? '';
    final String otp = args?['otp'] ?? '';

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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Minimum length password 8 character with Letter and number combination',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      if (value!.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _conformPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter confirm password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Visibility(
                          visible: _resetPasswordInProgress == false,
                          replacement: const Center_progress_indegator(),
                          child: FilledButton(
                            onPressed: () {
                              if (email.isEmpty || otp.isEmpty) {
                                Showsnackbarmessage(
                                  context,
                                  'Invalid request. Please try again from the beginning.',
                                );
                                return;
                              }
                              _onTapResetPasswordButton(email, otp);
                            },
                            child: const Text('Confirm'),
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

  void _onTapResetPasswordButton(String email, String otp) {
    if (_formkey.currentState!.validate()) {
      _resetPassword(email, otp);
    }
  }

  Future<void> _resetPassword(String email, String otp) async {
    _resetPasswordInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": _passwordController.text,
    };

    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.RecoverResetPassUrl,
      body: requestBody,
    );

    _resetPasswordInProgress = false;
    setState(() {});

    if (response.isSuccess && response.responseData['status'] == 'success') {
      if (mounted) {
        Showsnackbarmessage(context, 'Password reset successful! Please login.');
        Get.offAllNamed(LoginScreen.name, predicate: (route) => false);
      }
    } else {
      if (mounted) {
        String errorMsg = response.errorMassage ?? 'Failed to reset password';
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
    _passwordController.dispose();
    _conformPasswordController.dispose();
    super.dispose();
  }
}
