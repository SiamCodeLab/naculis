import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../routes/route_name.dart';

class RegistrationOtpController extends GetxController {
  final isLoading = false.obs;
  final email = ''.obs;
  late Uri url;

  @override
  void onInit() {
    super.onInit();
    setEmail(Get.arguments?['email'] ?? '');
    url = Uri.parse(ApiEndpoints.verifyRegistration); // Registration endpoint
  }

  void setEmail(String value) {
    email.value = value;
  }

  Future<void> verifyOtp(String otp) async {
    if (otp.length != 6) {
      Get.snackbar('Error', 'OTP must be 6 digits');
      return;
    }

    isLoading.value = true;

    print("Sending Registration OTP: ${email.value} | OTP: $otp");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.value, "otp": otp}),
      );

      final data = json.decode(response.body);
      print("Status: ${response.statusCode}");
      print("Response: $data");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'OTP verified successfully');
        Get.offAllNamed(RouteName.signin);
      } else {
        Get.snackbar('Error', data['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
