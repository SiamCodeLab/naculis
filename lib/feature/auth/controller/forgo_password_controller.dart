import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../routes/route_name.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendForgotPasswordRequest() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.forgotPassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);
      print("Forgot Password Response: $data");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP sent to email');
        Get.toNamed(
          RouteName.forgetpasswordOtp,
          arguments: {'email': email, 'isForgotPassword': true},
        );
      } else {
        Get.snackbar('Error', data['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
