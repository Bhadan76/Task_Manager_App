import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_app/ui/controllers/new_password_controller.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';

class NewPasswordSetScreen extends StatefulWidget {
  const NewPasswordSetScreen({super.key});

  static const String name = '/new-password-set';

  @override
  State<NewPasswordSetScreen> createState() => _NewPasswordSetScreenState();
}

class _NewPasswordSetScreenState extends State<NewPasswordSetScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController =
      TextEditingController();
  final NewPasswordController _newPasswordController =
      Get.find<NewPasswordController>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Map<String, dynamic> get _args {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      return args;
    }
    return {};
  }

  String get _email =>
      _args['email']?.toString() ??
      Get.find<ForgotPasswordEmailController>().recoveryEmail ??
      '';

  String get _otp => _args['otp']?.toString() ?? '';

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
                        GetBuilder<NewPasswordController>(
                          builder: (controller) {
                            return Visibility(
                              visible:
                                  controller.resetPasswordInProgress == false,
                              replacement: const Center_progress_indegator(),
                              child: FilledButton(
                                onPressed: _onTapResetPasswordButton,
                                child: const Text('Confirm'),
                              ),
                            );
                          },
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

  void _onTapResetPasswordButton() {
    if (_email.isEmpty || _otp.isEmpty) {
      ShowSnackbarMessage(
        'Task Manager App',
        'Invalid request. Please try again from the beginning.',
      );
      return;
    }

    if (_formkey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    final bool isSuccess = await _newPasswordController.resetPassword(
      email: _email,
      otp: _otp,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (isSuccess) {
      ShowSnackbarMessage(
        'Task Manager App',
        'Password reset successful! Please login.',
      );
      Get.offAllNamed(LoginScreen.name, predicate: (route) => false);
    } else {
      ShowSnackbarMessage(
        'Task Manager App',
        _newPasswordController.errorMessage ?? 'Failed to reset password',
      );
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
