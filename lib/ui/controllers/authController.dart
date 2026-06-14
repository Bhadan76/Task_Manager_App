import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class Authcontroller {
  static const String _accessTokenKey = 'token';
  static const String _userTokenKey = 'user';
  static const String _loggedInEmailsKey = 'logged_in_emails';
  static String? accessToken;
  static UserModel? usermodel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(
      _userTokenKey,
      jsonEncode(model.toJson()),
    );
    
    // Save email to history for forgot password check
    List<String> emails = sharedPreferences.getStringList(_loggedInEmailsKey) ?? [];
    if (!emails.contains(model.email.toLowerCase())) {
      emails.add(model.email.toLowerCase());
      await sharedPreferences.setStringList(_loggedInEmailsKey, emails);
    }

    accessToken = token;
    usermodel = model;
  }

  static Future<bool> isEmailInHistory(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> emails = sharedPreferences.getStringList(_loggedInEmailsKey) ?? [];
    return emails.contains(email.toLowerCase());
  }

  //app ta restart korar pore o abr data load korar jonno
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userTokenKey);

    if (token != null && token.isNotEmpty && userData != null && userData.isNotEmpty) {
      try {
        usermodel = UserModel.formJson(jsonDecode(userData));
        accessToken = token;
      } catch (e) {
        await clearUserData();
      }
    }

  }

  static Future<bool> isUserAlreadyLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userTokenKey);
    if (token != null && token.isNotEmpty && userData != null && userData.isNotEmpty) {
      await getUserData();
      return accessToken != null;
    }
    return false;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userTokenKey);
    accessToken = null;
    usermodel = null;
  }
}
