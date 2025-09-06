import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../model/get_level_model.dart';

class LevelsController extends GetxController {
  RxList<LevelModel> levelList = <LevelModel>[].obs;
  RxMap<String, dynamic> levelDetails = <String, dynamic>{}.obs;
  String arg= '';

  int levelid = 0;
  int index = 0;

  int qIndex=0;
  String title='';

  @override
  void onInit() {
    super.onInit();
    fetchLevels();
  }

  Future<void> fetchLevels() async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse(ApiEndpoints.getLevels);
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      print('Game level statu code ${response.statusCode}, and body: ${response.body}');
      Get.snackbar(
        'Response Status',
        'Status Code: ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 2000),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        levelList.value = LevelModel.fromJsonList(jsonResponse);
        print(levelList);
      } else {
        // Get.snackbar('Error', 'Server returned ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchLevelDetails() async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse("${ApiEndpoints.levelDetails}$levelid/");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        levelDetails.value = jsonResponse;
        print(levelDetails);
      } else {
        Get.snackbar('Error', 'Server returned ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
