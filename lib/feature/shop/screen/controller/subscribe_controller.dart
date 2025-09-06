import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/const/api_endpoints.dart';
import '../../../../core/const/nav_ids.dart';
import '../../../../core/local_storage/user_info.dart';
import '../shop_screen3.dart';


class ShopSubscriptionController extends GetxController {
  var isLoading = false.obs;
  var isConfirming = false.obs;



  /// Step 1: Start PayPal subscription
  Future<void> startSubscription() async {
    try {
      isLoading.value = true;
      String? accessToken = await UserInfo.getAccessToken();
      final response = await http.post(
        Uri.parse(ApiEndpoints.startSubscription),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'},
        body: jsonEncode({
          "plan":"half_yearly"
        })
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final approvalUrl = data['approval_url'];

        if (approvalUrl != null && approvalUrl.toString().isNotEmpty) {
          Get.to(
                () => ShopScreen3(url:  approvalUrl.toString(),


                    // Optionally, you can navigate to another screen or update the UI




            ),
            id: NavIds.shop,
          );
        } else {
          Get.snackbar("Error", "Approval URL not found");
        }
      } else {
        Get.snackbar("Error", "Failed to start subscription");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


}
