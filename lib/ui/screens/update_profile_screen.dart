import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/controllers/update_profile_controller.dart';
import 'package:task_manager_app/ui/widgets/app_bar_widget.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/photo_picker_filed.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name = '/update profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();
  @override
  void initState() {
    super.initState();
    _emailController.text = Authcontroller.usermodel?.email ?? '';
    _firstNameController.text = Authcontroller.usermodel?.firstName ?? '';
    _lastNameController.text = Authcontroller.usermodel?.lastName ?? '';
    _mobileController.text = Authcontroller.usermodel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar_widget(formUpdateProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24),
                photo_picker_filed(onTap: _updateProfileController.pickImage, selectedPhoto: _updateProfileController.selectedImage,),
                SizedBox(height: 10),
                TextFormField(
                  enabled: false,
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your first name';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your Last name';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter a mobile number';
                    }
                    if ((value?.length ?? 0) != 11) {
                      return 'Enter a 11 digit mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                SizedBox(height: 82),
                GetBuilder<UpdateProfileController>(
                  builder: (controller) {
                    return Visibility(
                      visible: _updateProfileController.updateProfileInProgress== false,
                      replacement: Center_progress_indegator(),
                      child: FilledButton(
                        onPressed: _onTapUpdateButton,
                        child: const Icon(Icons.arrow_circle_right),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton(){
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }
  Future <void> _updateProfile() async {
    bool isSuccess = await _updateProfileController.addNewTasks(
      _emailController.text.trim(),
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _mobileController.text.trim()
    );

    if(isSuccess){
      _passwordController.clear();
      ShowSnackbarMessage( 'Task Manager App', 'Profile updated successfully!');

    }else{
        ShowSnackbarMessage( 'Task Manager App', _updateProfileController.errorMessage ?? 'Update failed!');
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
