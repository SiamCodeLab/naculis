import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding the response body

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../model/model_class.dart';

class WithdrawController extends GetxController {
  var isLoading = false.obs;
  var balanceDetails = BalanceDetails(
    availableBalanceGems: 0,
    usdEquivalent: 0,
    conversionRate: '0',
    withdrawMessage: '',
    activity: Activity(received: [], requested: [], rejected: []),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchBalanceDetails();
  }

  // Fetch balance details from the API
  Future<void> fetchBalanceDetails() async {
    isLoading.value = true;
    try {
      // Read the access token from GetStorage

      String? accessToken = await UserInfo.getAccessToken();

      // Define the API URL
      final url = Uri.parse(ApiEndpoints.walletActivity);

      // Make the GET request with authorization header
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken', // Add access token in the header
        },
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        // Decode the JSON response body
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Update the balance details using the response data
        balanceDetails.value = BalanceDetails(
          availableBalanceGems: responseData['available_balance_gems'],
          usdEquivalent: responseData['usd_equivalent'],
          conversionRate: responseData['conversion_rate'],
          withdrawMessage: responseData['withdraw_message'],
          activity: Activity.fromJson(responseData['activity']),
        );

        isLoading.value = false; // Set isLoading to false once the data is fetched
      } else {
        // Handle error if the response status is not 200
        print('Error: Failed to fetch balance details');
      }
    } catch (e) {
      // Handle errors (e.g., no internet connection, API failure)
      print('Error fetching balance details: $e');
    } finally {
      // Ensure isLoading is set to false once the request is complete
      isLoading.value = false;
    }
  }
}
