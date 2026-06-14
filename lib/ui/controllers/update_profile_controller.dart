import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    XFile? pickImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickImage != null) {
      _selectedImage = pickImage;
      update();
    }
  }

  Future<bool> addNewTasks(
    String email,
    String firstName,
    String lastName,
    String mobile,

  ) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes); // API expects 'photo'
    }
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: requestBody['photo'] ?? Authcontroller.usermodel?.photo,
      );
      await Authcontroller.saveUserData(userModel, Authcontroller.accessToken!);
      _errorMessage = 'Profile updated successfully!';

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }
}
