import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void ShowSnackbarMessage(String tittle, String message) {
  Get.snackbar(
    tittle,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    duration: const Duration(seconds: 3),
  );
}
