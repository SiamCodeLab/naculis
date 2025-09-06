import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';

class LeaderboardController extends GetxController {
  var leaderboard = <Map<String, dynamic>>[].obs; // To store leaderboard data
  var isLoading = false.obs; // To track loading state
  var errorMessage = ''.obs; // To store error message

  // API call to fetch daily streak data
  Future<void> fetchDailyStreak() async {
    _fetchData(ApiEndpoints.dailyStreak);
  }

  // API call to fetch XP data
  Future<void> fetchXP() async {
    _fetchData(ApiEndpoints.xp);
  }

  // API call to fetch Gems data
  Future<void> fetchGems() async {
    _fetchData(ApiEndpoints.gems);
  }

  // API call to fetch perfect lessons data
  Future<void> fetchPerfectLessons() async {
    _fetchData(ApiEndpoints.perfectLesson);
  }

  // Internal method to fetch data for any of the endpoints
  Future<void> _fetchData(String url) async {
    try {
      String? accessToken = await UserInfo.getAccessToken();
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null && data['results']['leaderboard'] != null) {
          leaderboard.value = List<Map<String, dynamic>>.from(
            data['results']['leaderboard'],
          );
        } else {
          errorMessage.value = 'Leaderboard data is empty';
        }
      } else {
        errorMessage.value =
        'Failed to load data. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

}
