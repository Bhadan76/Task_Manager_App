import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/ui/controllers/authController.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri,headers: {
        'token': Authcontroller.accessToken ?? ''
      });
      _logResponse(url, response);

      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        //Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else if(statusCode == 401){
        _movetoLogin();
        return ApiResponse(
            isSuccess: false,
            responseData: null,
            responseCode: statusCode,
            errorMassage: 'Un-authorized'
        );
      } else {
        try {
          final decodedData = jsonDecode(response.body);
          return ApiResponse(
              isSuccess: false,
              responseData: decodedData,
              responseCode: statusCode,
              errorMassage: decodedData['data'] ?? 'Something went wrong'
          );
        } catch (e) {
          return ApiResponse(
              isSuccess: false,
              responseData: null,
              responseCode: statusCode,
              errorMassage: 'Server returned an invalid response'
          );
        }
      }
    } on FormatException {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMassage: 'Invalid data format from server',
      );
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': Authcontroller.accessToken ?? ''
        },
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final int statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseData: decodedData,
          responseCode: statusCode,
        );
      } else if (statusCode == 401) {
        _movetoLogin();
        return ApiResponse(
            isSuccess: false,
            responseData: null,
            responseCode: statusCode,
            errorMassage: 'Un-authorized'
        );
      } else {
        try {
          final decodedData = jsonDecode(response.body);
          return ApiResponse(
              isSuccess: false,
              responseData: decodedData,
              responseCode: statusCode,
              errorMassage: decodedData['data'] ?? 'Something went wrong'
          );
        } catch (e) {
          return ApiResponse(
              isSuccess: false,
              responseData: null,
              responseCode: statusCode,
              errorMassage: 'Server returned an invalid response'
          );
        }
      }
    } on FormatException {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMassage: 'Invalid data format from server',
      );
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        responseCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL => $url \n'
      'request body: $body',
    );
  }

  static void _logResponse(String url, Response response) {
    _logger.i(
      'Url => $url\n'
      'Status code: ${response.statusCode}\n'
      'Body : ${response.body}',
    );
  }
  static Future<void> _movetoLogin() async {
    await Authcontroller.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, LoginScreen.name, (predicate)=> false);
  }
}

class ApiResponse {
  final bool isSuccess;
  final dynamic responseData;
  final int responseCode;
  final String? errorMassage;

  ApiResponse({
    required this.isSuccess,
    required this.responseData,
    required this.responseCode,
    this.errorMassage = 'Something went wrong',
  });
}
