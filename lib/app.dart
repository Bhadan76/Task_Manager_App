
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_verify_OTP_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager_app/ui/screens/new_password_set_screen.dart';
import 'package:task_manager_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/signup_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';
import 'ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
         colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationThemeData(
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),

          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          )

        )

      ),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (_)=> SplashScreen(),
        LoginScreen.name: (_)=> LoginScreen(),
        SignupScreen.name : (_)=> SignupScreen(),
        ForgotPasswordVerifyEmailScreen.name : (_)=> ForgotPasswordVerifyEmailScreen(),
        ForgotPasswordVerifyOtpScreen.name: (_)=> ForgotPasswordVerifyOtpScreen(),
        NewPasswordSetScreen.name: (_)=> NewPasswordSetScreen(),
        MainNavbarHolderScreen.name: (_)=> MainNavbarHolderScreen(),
        NewTaskScreen.name : (_)=> NewTaskScreen(),
        UpdateProfileScreen.name : (_)=> UpdateProfileScreen(),
        AddNewTaskScreen.name : (_)=> AddNewTaskScreen(),
      },

    );
  }
}
