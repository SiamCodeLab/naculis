import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';

class LessonController extends GetxController {
  var level = 0.obs;
  var totalLessons = 0.obs;
  var totalXp = 0.obs;
  var completedLessons = 0.obs;
  var earnedXp = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLessonProgress(); // Fetch lesson progress on init
  }

  Future<void> fetchLessonProgress() async {
    isLoading.value = true;
    try {
      String? accessToken = await UserInfo.getAccessToken();
      final response = await http.get(
        Uri.parse(ApiEndpoints.lessonquest), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        level.value = data['level'] ?? 0;
        totalLessons.value = data['total_lessons'] ?? 0;
        totalXp.value = data['total_xp'] ?? 0;
        completedLessons.value = data['completed_lessons'] ?? 0;
        earnedXp.value = data['earned_xp'] ?? 0;
      } else {
        Get.snackbar('Error', 'Failed to fetch lesson progress');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
