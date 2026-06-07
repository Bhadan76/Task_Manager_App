import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utils/AssetPaths.dart';
class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.10,
              child: Image.asset(
                Assetpaths.BackgroundImg,
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),

    );
  }
}
