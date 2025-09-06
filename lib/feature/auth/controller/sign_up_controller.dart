import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../routes/route_name.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referCodeController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  Future<void> registerUser() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final referCode = referCodeController.text.trim(); // optional

    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.signup),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "email": email,
          "phone": phone,
          "password": password,
          "confirm_password": confirmPassword,
          if (referCode.isNotEmpty) "referral_code": referCode,
        }),
      );

      final data = jsonDecode(response.body);
      print("Register Response: $data");
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Sent OTP to your email');

        // Pass email to OTP screen
        Get.toNamed(
          RouteName.registerationOtp,
          arguments: {'email': email, 'isForgotPassword': false},
        );
      } else {
        // Properly extract error messages from backend
        String errorMessage = '';

        if (data.containsKey('non_field_errors')) {
          errorMessage = (data['non_field_errors'] as List).join(', ');
        } else if (data.containsKey('username')) {
          errorMessage = (data['username'] as List).join(', ');
        } else if (data.containsKey('email')) {
          errorMessage = (data['email'] as List).join(', ');
        } else if (data.containsKey('phone')) {
          errorMessage = (data['phone'] as List).join(', ');
        } else {
          errorMessage = 'Registration failed';
        }

        Get.snackbar('Error', errorMessage);
      }

    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
