import 'dart:convert'; // <-- add this
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';
import 'mood_model.dart';
import 'slang_model.dart';

class SlangController extends GetxController {
  RxList<SlangModel> slangList = <SlangModel>[].obs;
  RxList<int> selectedSlangList = <int>[].obs;
  RxList<int> feelsList = <int>[].obs;

  RxList<MoodModel> moodList = <MoodModel>[].obs;
  RxList<int> selectedVibeList = <int>[].obs;
  RxList<int> vibeList = <int>[].obs;

  RxString language = ''.obs;
  RxList<int> selectedFeelingIndices = <int>[].obs;

  RxBool isSelected = false.obs;
  RxInt selectedIndex = (-1).obs;


  Future<void> fetchSlangList() async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse(ApiEndpoints.slangCategories);
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        slangList.value = SlangModel.fromJsonList(jsonResponse);
      } else {
        print('Failed to fetch slang list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching slang list: $e');
    }
  }

  Future<void> fetchMoodList() async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse(ApiEndpoints.moodCategories);
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        moodList.value = MoodModel.fromJsonList(jsonResponse);
      } else {
        print('Failed to fetch mood list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching mood list: $e');
    }
  }

  Future<void> postMoodData() async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse(ApiEndpoints.onboardingProcess);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // add this for JSON
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "slang_vibes": feelsList.toList(), // RxList → List
          "mood_vibes": vibeList.toList(), // RxList → List
          "preferred_language": language.value, // RxString → String
        }),
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(RouteName.home);

      } else {
        Get.snackbar('Error', 'Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting mood data: $e');
    }
  }

  Future<void> postlanguage(String language) async {
    String? accessToken = await UserInfo.getAccessToken();
    final url = Uri.parse(ApiEndpoints.onboardingProcess);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // add this for JSON
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          // RxList → List
          "preferred_language": language, // RxString → String
        }),
      );

      if (response.statusCode == 200) {
        Get.toNamed(RouteName.home);
      } else {
        Get.snackbar('Error', 'Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting language data: $e');
    }
  }

  @override
  void onInit() {
    fetchSlangList();
    fetchMoodList();
    super.onInit();
  }
}
