
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/binding_controller.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_verify_OTP_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager_app/ui/screens/new_password_set_screen.dart';
import 'package:task_manager_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/signup_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

import 'package:task_manager_app/ui/controllers/app_bar_theme_controller.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final AppBarThemeController themeController = Get.put(AppBarThemeController(), permanent: true);

    return Obx(() {
      return GetMaterialApp(
        themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: const InputDecorationThemeData(
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.black38,
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
              fixedSize: const Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
            )
          )
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialBinding: BindingController(),
        theme: ThemeData(
           colorSchemeSeed: Colors.green,
          inputDecorationTheme: const InputDecorationThemeData(
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
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
            )
          )
        ),
        initialRoute: SplashScreen.name,
        getPages: [
          GetPage(name: SplashScreen.name, page: () => const SplashScreen()),
          GetPage(name: LoginScreen.name, page: () => const LoginScreen()),
          GetPage(name: SignupScreen.name, page: () => const SignupScreen()),
          GetPage(
            name: ForgotPasswordVerifyEmailScreen.name,
            page: () => const ForgotPasswordVerifyEmailScreen(),
          ),
          GetPage(
            name: ForgotPasswordVerifyOtpScreen.name,
            page: () => const ForgotPasswordVerifyOtpScreen(),
          ),
          GetPage(
            name: NewPasswordSetScreen.name,
            page: () => const NewPasswordSetScreen(),
          ),
          GetPage(
            name: MainNavbarHolderScreen.name,
            page: () => const MainNavbarHolderScreen(),
          ),
          GetPage(name: NewTaskScreen.name, page: () => const NewTaskScreen()),
          GetPage(
            name: UpdateProfileScreen.name,
            page: () => const UpdateProfileScreen(),
          ),
          GetPage(
            name: AddNewTaskScreen.name,
            page: () => const AddNewTaskScreen(),
          ),
        ],
      );
    });
  }
}
