import 'dart:collection';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';

class NotificationsController extends GetxController {
  Rx<HashMap<String, dynamic>> notificationsResponse = HashMap<String, dynamic>().obs;

  // Observable for unread notifications count
  var unreadCount = 0.obs;

  // Observable for the response message
  var message = ''.obs;

  // Loading state
  var isLoading = true.obs;

  @override
  onInit() {
    super.onInit();
    fetchNotifications(); // Fetch notifications on init
  }

  // Fetch notifications from the API
  Future<void> fetchNotifications() async {
    isLoading(true);
    String? accessToken = await UserInfo.getAccessToken();
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.notification),
          headers: {
            'Content-Type': 'application/json',
            // Add authorization header if required
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null) {
          this.notificationsResponse.value = HashMap<String, dynamic>.from(data);

          unreadCount.value = data['results']['unread_count'] ?? 0;
          message.value = data['results']['message'] ?? 'No new notifications';
        } else {
          message.value = 'No notifications found.';
        }

        print(notificationsResponse);
      } else {
        // Handle API failure (non-200 status)
        message.value = 'Failed to load notifications: ${response.statusCode}';
      }
    } catch (e) {
      // Handle any errors during the fetch
      message.value = 'Error: $e';
    } finally {
      isLoading(false); // Set loading to false after the request is completed
    }
  }
  // Delete a notification by ID
  Future <void> deleteAllNotifications()async{
    isLoading(true);
    String? accessToken = await UserInfo.getAccessToken();
    try {
      final response = await http.delete(Uri.parse(ApiEndpoints.deleteNotification),
          headers: {
            'Content-Type': 'application/json',
            // Add authorization header if required
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        // Successfully deleted the notification
        message.value = 'All notifications deleted successfully';
        notificationsResponse.value.clear(); // Clear the notifications list
        unreadCount.value = 0; // Reset unread count
      } else {
        // Handle API failure (non-200 status)
        message.value = 'Failed to delete notifications: ${response.statusCode}';
      }
    } catch (e) {
      // Handle any errors during the delete request
      message.value = 'Error: $e';
    } finally {
      isLoading(false); // Set loading to false after the request is completed
    }
  }
}
