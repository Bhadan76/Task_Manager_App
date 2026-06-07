import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class appBar_widget extends StatefulWidget implements PreferredSizeWidget {
  const appBar_widget({super.key, this.formUpdateProfile});

  final bool? formUpdateProfile;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<appBar_widget> createState() => _appBar_widgetState();
}

class _appBar_widgetState extends State<appBar_widget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (widget.formUpdateProfile ?? false) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
          ).then((value) {
            setState(() {});
          });
        },
        child: Row(
          children: [
            _buildUserAvatar(),
            const SizedBox(width: 8),
            _buildUserInfo(),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: logOut, icon: const Icon(Icons.logout)),
      ],
    );
  }

  Widget _buildUserAvatar() {
    String? photoBase64 = Authcontroller.usermodel?.photo;
    
    if (photoBase64 != null && photoBase64.isNotEmpty) {
      try {
        // Handle cases where the base64 string might be prefixed
        if (photoBase64.contains(',')) {
          photoBase64 = photoBase64.split(',').last;
        }
        Uint8List imageBytes = base64Decode(photoBase64);
        return CircleAvatar(
          backgroundImage: MemoryImage(imageBytes),
        );
      } catch (e) {
        // Fallback if decoding fails
      }
    }
    
    return const CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, color: Colors.white),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Authcontroller.usermodel?.fullName ?? '',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        Text(
          Authcontroller.usermodel?.email ?? '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Future<void> logOut() async {
    await Authcontroller.clearUserData();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
        (predicate) => false,
      );
    }
  }
}
