import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/const/api_endpoints.dart';
import '../../../../core/local_storage/user_info.dart';
import '../../../../routes/route_name.dart';
import '../../../user_profile/user_profile_controller/profile_controller.dart';

class HeartController extends GetxController {
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final controller = Get.put(UserController());

  final String getHeartUrl = ApiEndpoints.getheart;
  final String refillOneHeartUrl = ApiEndpoints.refilloneHeart;
  final String refillAllHeartUrl = ApiEndpoints.refillAlleHeart;

  Rx<HashMap<String, dynamic>> heartsData = HashMap<String, dynamic>().obs;
  Rx<HashMap<String, dynamic>> exchangeRate = HashMap<String, dynamic>().obs;
  Rx<HashMap<String, dynamic>> payout = HashMap<String, dynamic>().obs;


  @override
  void onInit() {
    super.onInit();
    getAllHeart();
  }

  /// Fetch all heart data
  void getAllHeart() async {
    String? accessToken = await UserInfo.getAccessToken();
    final response = await http.get(
      Uri.parse(getHeartUrl),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      print('Hearts data: ${response.body}');
      var heartsData = jsonDecode(response.body);
      this.heartsData.value = HashMap<String, dynamic>.from(heartsData);
      controller.fetchUserData();
    } else {
      print('Failed to load hearts: ${response.statusCode}');
    }
  }

  /// Refill all hearts
  void refillAllHeart() async {
    String? accessToken = await UserInfo.getAccessToken();
    final response = await http.post(
      Uri.parse(refillAllHeartUrl),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      print('Hearts refilled: ${response.body}');
      getAllHeart();
      controller.fetchUserData();
    } else {
      print('Failed to refill hearts: ${response.statusCode}');
    }
  }

  /// Refill one heart
  void refillOneHeart() async {
    String? accessToken = await UserInfo.getAccessToken();
    final response = await http.post(
      Uri.parse(refillOneHeartUrl),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      print('Hearts refilled: ${response.body}');
      getAllHeart();
      controller.fetchUserData();
    } else {
      print('Failed to refill hearts: ${response.statusCode}');
    }
  }

  /// Fetch gems to USD exchange rate
  void exchangeGems() async {
    String? accessToken = await UserInfo.getAccessToken();
    final response = await http.get(
      Uri.parse(ApiEndpoints.exchangeGems),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      print('conversion_rate: ${response.body}');
      var heartsData = jsonDecode(response.body);
      this.exchangeRate.value = HashMap<String, dynamic>.from(heartsData);
    } else {
      print('Failed to load exchange rate: ${response.statusCode}');
    }
  }

  /// Request payout to PayPal
  Future<bool> payoutRequest() async {
    final email = emailController.text.trim();
    final amountText = amountController.text.trim();

    if (email.isEmpty || amountText.isEmpty) {
      Get.snackbar("Error", "Please enter all fields");
      return false;
    }

    final amount = double.tryParse(amountText) ?? 0;

    if (amount < 1000) {
      Get.snackbar("Error", "Minimum withdrawal is 1000 gems.");
      return false;
    }

    try {
      String? accessToken = await UserInfo.getAccessToken();
      final response = await http.post(
        Uri.parse(ApiEndpoints.payoutRequest),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({'gem': amountText, 'paypal_email': email}),
      );

      if (response.statusCode == 201) {
        payout.value = HashMap<String, dynamic>.from(jsonDecode(response.body));
        Get.snackbar(
          'Success',
          "Message: ${payout.value['message']}\n"
              "Payout ID: ${payout.value['payout_id']}\n",
        );
        emailController.clear();
        amountController.clear();
        Get.offNamed(RouteName.home);
        getAllHeart();
        controller.fetchUserData();
        return true; // payout success
      } else {
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error'] ?? 'Failed to request payout';
        Get.snackbar('Error', errorMsg);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
      return false;
    }
  }
}
