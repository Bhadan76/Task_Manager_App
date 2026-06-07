import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/widgets/app_bar_widget.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/photo_picker_filed.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';

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

  final ImagePicker _imagePicker =ImagePicker();
  XFile? _selectedImage;

  bool _updateProfileInProgress = false;

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
                photo_picker_filed(onTap: _pickImage, selectedPhoto: _selectedImage,),
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
                Visibility(
                  visible: _updateProfileInProgress== false,
                  replacement: Center_progress_indegator(),
                  child: FilledButton(
                    onPressed: _onTapUpdateButton,
                    child: const Icon(Icons.arrow_circle_right),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _pickImage() async {
    XFile? pickImage=await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickImage!= null){
         _selectedImage= pickImage;
         setState(() {});
    }
  }
  void _onTapUpdateButton(){
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }
  Future <void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'email': _emailController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'mobile': _mobileController.text.trim(),
    };
    if(_selectedImage != null){
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes); // API expects 'photo'
    }
    if(_passwordController.text.isNotEmpty){
      requestBody['password'] = _passwordController.text;
    }
    ApiResponse response = await ApiCaller.postRequest(url: Urls.updateProfileUrl,body: requestBody);
    _updateProfileInProgress = false;
    setState(() {});
    if(response.isSuccess){
      UserModel userModel = UserModel(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        photo: requestBody['photo'] ?? Authcontroller.usermodel?.photo,
      );
      await Authcontroller.saveUserData(userModel, Authcontroller.accessToken!);
      _passwordController.clear();

       setState(() {
         Showsnackbarmessage(context, 'Profile updated successfully!');

       });
    }else{
      setState(() {
        Showsnackbarmessage(context, response.errorMassage ?? 'Update failed!');

      });
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
