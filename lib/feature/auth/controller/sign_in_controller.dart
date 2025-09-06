import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';
import '../../user_profile/user_profile_controller/profile_controller.dart';

class SignInController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;


  Future<void> loginUser() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    isLoading.value = true;

    const url = ApiEndpoints.login;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      final data = json.decode(response.body);
      print('Status Code for login ${response.statusCode} and body is ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        UserInfo.setAccessToken(data['access']);
        UserInfo.setRefreshToken(data['refresh']);
        UserInfo.setIsLoggedIn(true);
        UserInfo.setUserRole(data['role']);
        UserInfo.setIsPremium(data['is_premium'] ?? false);
        Get.offAllNamed(RouteName.oftenLang);
      }
      else {
        if (data['username'] != null) {
          Get.snackbar('Error', data['username'][0]);
        } else if (data['email'] != null) {
          Get.snackbar('Error', data['email'][0]);
        } else if (data['password'] != null) {
          Get.snackbar('Error', data['password'][0]);
        } else if (data['message'] != null) {
          Get.snackbar('Error', data['message']);
        } else {
          Get.snackbar('Error', 'Login failed');
        }
      }

    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }
}
