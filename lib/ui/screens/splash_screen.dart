import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager_app/ui/utils/AssetPaths.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name= '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      final bool isLogedIn = await Authcontroller.isUserAlreadyLogIn();
      if (isLogedIn) {
        await Authcontroller.getUserData();
        if (mounted) {
          Get.offNamed(MainNavbarHolderScreen.name);
        }
      } else {
        if (mounted) {
          Get.offNamed(LoginScreen.name);
        }
      }
    } catch (e) {
      // If error occurs, fallback to login
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            Assetpaths.LogoImg,
            height: 80,
          ),
        ),
      ),
    );
  }
}
