import 'dart:collection';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';

class PersonalityController extends GetxController {
  Rx<HashMap<String, dynamic>> personality = HashMap<String, dynamic>().obs;


  final url = Uri.parse(ApiEndpoints.personality);

  Future<void> getPersonality() async {
    String? accessToken = await UserInfo.getAccessToken();
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        // Replace the whole map to trigger Obx
        personality.value =
        HashMap<String, dynamic>.from(jsonDecode(response.body));
        print(personality);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> addPersonality() async {
    String? accessToken = await UserInfo.getAccessToken();
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        personality.value =
        HashMap<String, dynamic>.from(jsonDecode(response.body));
        print(personality);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
