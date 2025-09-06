import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';

class LogoutController extends GetxController {
  final isLoading = false.obs;

  Future<void> logout() async {
    final url = Uri.parse(ApiEndpoints.logout);
    String? access = await UserInfo.getAccessToken();
    String? refresh = await UserInfo.getRefreshToken();

    isLoading.value = true;
    try {
      final response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (access != null) 'Authorization': 'Bearer $access',
        },
        body: jsonEncode({
          'refresh': refresh, // adjust key name if your API expects different
        }),
      )
          .timeout(const Duration(seconds: 15));

      // Treat 2xx as success
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // _clearAuthKeepPrefs();
        print(response.statusCode);
        print(response.body);
        Get.offAllNamed(RouteName.signin);
      } else {

        Get.snackbar('Signed out', 'Signed out Failled (${response.statusCode}).');
      }
    } catch (e) {

    } finally {
      isLoading.value = false;
    }
  }

  // void _clearAuthKeepPrefs() {
  //   final dark = _box.read('darkMode'); // keep theme
  //   _box.remove('access_token');
  //   _box.remove('refresh_token');
  //   // remove other session keys as needed
  //   if (dark != null) _box.write('darkMode', dark);
  // }
}
