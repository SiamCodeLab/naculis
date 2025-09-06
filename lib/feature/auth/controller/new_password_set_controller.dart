import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../routes/route_name.dart';

class NewPasswordSetController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();


  final url = Uri.parse(ApiEndpoints.resetPassword);
  var isLoading = false.obs;

  // You might need an email or token to identify the user resetting password




  Future<void> setNewPassword() async {
    final newPassword = newPasswordController.text.trim();
    final confirmNewPassword = confirmNewPasswordController.text.trim();

    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      Get.snackbar('Error', 'Both fields are required');
      return;
    }

    if (newPassword != confirmNewPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }



    isLoading.value = true;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({

          'new_password': newPassword,
          'confirm_password': confirmNewPassword,
        }),
      );

      final data = jsonDecode(response.body);
      print('Reset Password Response: $data');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Password reset successfully');
        // Navigate to sign in or another screen as needed
        Get.offAllNamed(RouteName.signin);
      } else {
        Get.snackbar('Error', data['message'] ?? 'Failed to reset password');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
