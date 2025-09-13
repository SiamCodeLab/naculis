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
import '../../home/controller/home_controller.dart';

class AnswerController extends GetxController {
  final LevelsController lcontroller = Get.find();
  int lessonId = 0;

  // Text input
  final TextEditingController controller = TextEditingController();

  // Loading & response
  RxBool isLoading = false.obs;
  var responseMessage = ''.obs;
  Rx<HashMap<String, dynamic>> aResponse = HashMap<String, dynamic>().obs;

  final String baseUrl = ApiEndpoints.ansSubmit;

  // Chat / messages
  var messages = <Map<String, dynamic>>[].obs;

  // Voice recorder/player
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  var isRecording = false.obs;
  String? filePath;

  @override
  void onInit() {
    super.onInit();
    lcontroller.fetchLevelDetails();
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
      recorder.setSubscriptionDuration(Duration(milliseconds: 50));
    } catch (e) {
      messages.add({
        'message': 'Error initializing recorder: $e',
        'isSender': false,
        'isVoice': false,
      });
    }
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.microphone.request();
    return status.isGranted;
  }
  //?
  ///

  Future<void> startRecording() async {
    if (!await requestPermissions()) return;
    if (recorder.isRecording) return;

    final dir = await getTemporaryDirectory();
    filePath = '${dir.path}/voice_message.aac';

    await recorder.startRecorder(toFile: filePath);
    isRecording.value = true;
    print("Recording started: $filePath");
  }

  Future<void> stopRecording() async {
    if (!recorder.isRecording) return;

    await recorder.stopRecorder();
    isRecording.value = false;

    if (filePath == null) return;

    final file = File(filePath!);

    if (!await file.exists() || await file.length() < 5000) {
      Get.snackbar('Recording too short', 'Please speak louder or longer.');
      return;
    }

    messages.add({
      'message': '[Voice Message Ready]',
      'isSender': true,
      'isVoice': true,
      'path': file.path,
    });

    // Only clear filePath **after** sending voice
    await sendVoice(file);
    filePath = null;
  }


  Future<String?> convertToMp3(String aacPath) async {
    final mp3Path = aacPath.replaceAll('.aac', '.mp3');
    final session = await FFmpegKit.execute(
      '-y -i "$aacPath" -codec:a libmp3lame -qscale:a 2 "$mp3Path"',
    );

    final returnCode = await session.getReturnCode();
    if (returnCode != null && returnCode.isValueSuccess()) {
      final mp3File = File(mp3Path);
      if (await mp3File.exists() && await mp3File.length() > 1000) {
        return mp3Path;
      }
    }
    return null;
  }

  Future<void> submitLesson({
    required int lessonId,
    required String answer,
  }) async {
    isLoading.value = true;
    try {
      String? token = await UserInfo.getAccessToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = json.encode({"lesson_id": lessonId, "answer": answer});

      var request = http.Request('POST', Uri.parse(baseUrl));
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBodyString = await response.stream.bytesToString();
        print("Full text response: $responseBodyString");

        var responseBody = jsonDecode(responseBodyString);
        responseMessage.value = responseBodyString;
        aResponse.value.addAll(responseBody);

        bool isCorrect =
            responseBody['submitted_answer']?['is_correct'] ?? false;
        String correctText = isCorrect ? "Correct" : "Wrong";

        Get.snackbar(
          "Your answer is",
          correctText,
          snackPosition: SnackPosition.TOP,
          backgroundColor: isCorrect
              ? Colors.green.withOpacity(0.8)
              : Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );

        messages.add({
          'message': responseBody['response'] ?? 'Answer submitted',
          'isSender': false,
          'isVoice': false,
          'isCorrect': isCorrect,
        });
      } else {
        responseMessage.value = 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      responseMessage.value = 'Exception: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendVoice(File file) async {
    isLoading.value = true; // start loading
    try {
      String? mp3Path = await convertToMp3(file.path);
      if (mp3Path == null || !await File(mp3Path).exists()) {
        messages.add({
          'message': 'Failed to convert audio to MP3',
          'isSender': false,
          'isVoice': false,
        });
        return;
      }

      String? token = await UserInfo.getAccessToken();
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'audio',
          mp3Path,
          contentType: MediaType('audio', 'mpeg'),
        ),
      );

      request.fields['type'] = 'voice';
      if (lessonId != 0) request.fields['lesson_id'] = lessonId.toString();

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        bool isCorrect =
            responseBody['submitted_answer']?['is_correct'] ?? false;
        String correctText = isCorrect ? "Correct" : "Wrong";

        Get.snackbar(
          "Your answer is",
          correctText,
          snackPosition: SnackPosition.TOP,
          backgroundColor: isCorrect
              ? Colors.green.withOpacity(0.8)
              : Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );

        messages.add({
          'message': responseBody['response'] ?? 'Voice submitted',
          'isSender': false,
          'isVoice': false,
          'isCorrect': isCorrect,
        });
      } else {
        messages.add({
          'message': 'Error: ${response.statusCode}',
          'isSender': false,
          'isVoice': false,
        });
      }
    } catch (e) {
      messages.add({
        'message': 'Failed to send voice: $e',
        'isSender': false,
        'isVoice': false,
      });
    } finally {
      isLoading.value = false; // stop loading
    }
  }


  /// ✅ Fixed submitAnswer: text OR voice OR both
  Future<void> submitAnswer() async {
    final hasText = controller.text.trim().isNotEmpty;
    final hasAudio = filePath != null;

    if (!hasText && !hasAudio) {
      Get.snackbar("No input", "Please provide text or audio.");
      return;
    }

    if (hasText) {
      await submitLesson(lessonId: lessonId, answer: controller.text.trim());
    }

    if (hasAudio) {
      final file = File(filePath!);
      await sendVoice(file);
    }

    controller.clear();
    filePath = null;
  }
}
