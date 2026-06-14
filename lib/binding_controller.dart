import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_app/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_otp_controller.dart';
import 'package:task_manager_app/ui/controllers/new_password_controller.dart';
import 'package:task_manager_app/ui/controllers/new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_app/ui/controllers/signin_controller.dart';
import 'package:task_manager_app/ui/controllers/signup_controller.dart';
import 'package:task_manager_app/ui/controllers/task_status_controller.dart';
import 'package:task_manager_app/ui/controllers/update_profile_controller.dart';

class BindingController extends Bindings{
  @override
  void dependencies() {
    Get.put(SigninController());
    Get.put(SignupController());
    Get.put(AddNewTaskController());
    Get.put(UpdateProfileController());
    Get.put(NewTaskController());
    Get.put(TaskStatusController());
    Get.put(ProgressTaskController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ForgotPasswordEmailController());
    Get.put(ForgotPasswordOtpController());
    Get.put(NewPasswordController());

  }

}