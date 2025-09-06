import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../../user_profile/user_profile_controller/profile_controller.dart';

class TaskController extends GetxController {
  var isLoading = false.obs;
  var taskList = <Map<String, dynamic>>[].obs;
  RxInt index = 0.obs;

  final TextEditingController answerController = TextEditingController();

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  var isRecording = false.obs;
  String? filePath;

  var messages = <Map<String, dynamic>>[].obs;
  Rx<HashMap<String, dynamic>> responseMap = HashMap<String, dynamic>().obs;


  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    initRecorder();
    player.openPlayer();
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.onClose();
  }

  Future<void> initRecorder() async {
    try {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
    } catch (e) {
      messages.add({'message': 'Recorder error: $e', 'isSender': false});
    }
  }

  Future<bool> requestPermissions() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> startRecording() async {
    if (!await requestPermissions()) return;
    if (recorder.isRecording) return;

    final dir = await getTemporaryDirectory();
    filePath = '${dir.path}/voice_message.aac';
    await recorder.startRecorder(toFile: filePath);
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    if (!recorder.isRecording) return;
    await recorder.stopRecorder();
    isRecording.value = false;

    if (filePath == null) return;

    final file = File(filePath!);

    int retries = 0;
    while (!await file.exists() || await file.length() < 5000) {
      await Future.delayed(const Duration(milliseconds: 100));
      retries++;
      if (retries > 30) break;
    }

    if (!await file.exists() || await file.length() < 5000) {
      messages.add({'message': 'Recording too short.', 'isSender': false});
      return;
    }

    messages.add({'message': '[Voice Ready]', 'isSender': true, 'isVoice': true, 'path': file.path});
    await sendVoice(file);
    filePath = null;
    answerController.clear();
  }

  Future<String?> convertToMp3(String aacPath) async {
    final mp3Path = aacPath.replaceAll('.aac', '.mp3');
    await FFmpegKit.execute('-y -i "$aacPath" -codec:a libmp3lame -qscale:a 2 "$mp3Path"');
    final mp3File = File(mp3Path);
    if (await mp3File.exists() && await mp3File.length() > 1000) return mp3Path;
    return null;
  }

  Future<void> sendVoice(File file) async {
    final mp3Path = await convertToMp3(file.path);
    if (mp3Path == null || !await File(mp3Path).exists()) {
      messages.add({'message': 'Failed to convert audio', 'isSender': false});
      print("Voice Conversion Failed for file: ${file.path}");
      return;
    }

    try {
      String? token = await UserInfo.getAccessToken();
      var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.ansSubmit));
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('audio', mp3Path, contentType: MediaType('audio', 'mpeg')));
      request.fields['type'] = 'voice';
      final lessonId = getCurrentLessonId();
      if (lessonId != null) request.fields['lesson_id'] = lessonId.toString();

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseBody = jsonDecode(response.body);

      print("Voice Answer Response: $responseBody"); // ✅ Debug print

      bool isCorrect = responseBody['submitted_answer']?['is_correct'] ?? false;
      String correctText = isCorrect ? "Correct" : "Wrong";

      Get.snackbar("Your answer is", correctText,
          backgroundColor: isCorrect ? Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.8),
          colorText: Colors.white);

      messages.add({'message': responseBody['response'] ?? 'Voice submitted', 'isSender': false, 'isVoice': false, 'isCorrect': isCorrect});
      responseMap.value.addAll(responseBody);

      nextQuestion();
    } catch (e) {
      messages.add({'message': 'Failed to send voice: $e', 'isSender': false});
      print("Voice Answer Exception: $e");
    }
  }

  Future<void> submitTextAnswer() async {
    final userController = Get.find<UserController>();
    if (userController.user.value.hearts == 0) {
      Get.snackbar("No Hearts Left", "You need at least 1 heart.", backgroundColor: Colors.red.withOpacity(0.8), colorText: Colors.white);
      return;
    }

    if (answerController.text.trim().isEmpty) {
      Get.snackbar("No Input", "Please type an answer or record voice.", backgroundColor: Colors.orange.withOpacity(0.8), colorText: Colors.white);
      return;
    }

    final lessonId = getCurrentLessonId();
    if (lessonId == null) return;

    await submitLesson(lessonId: lessonId, answer: answerController.text.trim());
    answerController.clear();
    userController.fetchUserData();
    nextQuestion();
  }

  Future<void> submitLesson({required int lessonId, required String answer}) async {
    isLoading.value = true;
    try {
      String? token = await UserInfo.getAccessToken();
      final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
      final body = json.encode({'lesson_id': lessonId, 'answer': answer});
      final request = http.Request('POST', Uri.parse(ApiEndpoints.ansSubmit));
      request.body = body;
      request.headers.addAll(headers);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseBody = jsonDecode(response.body);

      print("Text Answer Response: $responseBody"); // ✅ Debug print

      bool isCorrect = responseBody['submitted_answer']?['is_correct'] ?? false;
      String correctText = isCorrect ? "Correct" : "Wrong";

      Get.snackbar("Your answer is", correctText,
          backgroundColor: isCorrect ? Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.8),
          colorText: Colors.white);

      messages.add({'message': responseBody['response'] ?? 'Answer submitted', 'isSender': false, 'isVoice': false, 'isCorrect': isCorrect});
      responseMap.value.addAll(responseBody);
    } catch (e) {
      messages.add({'message': 'Exception: $e', 'isSender': false});
      print("Text Answer Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int? getCurrentLessonId() {
    try {
      if (taskList.isEmpty) return null;
      final group = taskList[index.value];
      final questions = group['questions'] as List? ?? [];
      if (questions.isEmpty) return null;
      return questions[0]['lesson_id'] as int?;
    } catch (e) {
      print('Error fetching lesson ID: $e');
      return null;
    }
  }

  void nextQuestion() {
    if (index.value < taskList.length - 1) {
      index.value++;
    } else {
      print('All tasks completed!');
    }
  }

  Future<void> fetchTasks() async {
    isLoading(true);
    try {
      String? token = await UserInfo.getAccessToken();
      final response = await http.get(Uri.parse(ApiEndpoints.autoTracked),
          headers: {
        'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        taskList.value = jsonData.map((e) => Map<String, dynamic>.from(e)).toList();
        print("Fetched tasks: $taskList"); // ✅ Debug print
      } else {
        Get.snackbar('Error', 'Failed to fetch tasks: ${response.statusCode}');
        print("Fetch tasks failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks: $e');
      print("Fetch tasks exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
