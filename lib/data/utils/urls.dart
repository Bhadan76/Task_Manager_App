
class Urls{
  static const String _baseUrl ='https://task.teamrabbil.com/api/v1';
  static const String registrationUrl ='$_baseUrl/registration';
  static const String loginUrl ='$_baseUrl/login';
  static const String createTaskUrl ='$_baseUrl/createTask';
  static const String taskStatusCountUrl ='$_baseUrl/taskStatusCount';
  static const String updateProfileUrl ='$_baseUrl/profileUpdate';
  static const String RecoverResetPassUrl ='$_baseUrl/RecoverResetPass';
  static String allTaskListUrl(String newStatus) => '$_baseUrl/listTaskByStatus/$newStatus';
  static String updateTaskStatusUrl(String id,String newStatus) => '$_baseUrl/updateTaskStatus/$id/$newStatus';
  static String deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
  static String forgotPasswordEmailVerifyUrl(String emailId) =>
      '$_baseUrl/RecoverVerifyEmail/${Uri.encodeComponent(emailId)}';
  static String forgotPasswordOtpVerifyUrl(String emailId, String otp) =>
      '$_baseUrl/RecoverVerifyOTP/${Uri.encodeComponent(emailId)}/${Uri.encodeComponent(otp)}';
}