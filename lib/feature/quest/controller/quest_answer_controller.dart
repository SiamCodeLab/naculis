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
  RxBool isAnswered = false.obs;

  // Text input
  final TextEditingController controller = TextEditingController();

  // Loading & response
  RxBool isLoading = false.obs; // single truth for network/IO
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
    try {
      lcontroller.fetchLevelDetails();
    } catch (_) {}
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

  Future<void> startRecording() async {
    if (!await requestPermissions()) {
      Get.snackbar('Permission denied', 'Microphone permission is required.');
      return;
    }
    if (recorder.isRecording) return;

    final dir = await getTemporaryDirectory();
    // We will still call stopRecorder() to get final path; pre-assigning safe path for some platforms
    filePath = '${dir.path}/voice_message.aac';

    try {
      await recorder.startRecorder(toFile: filePath);
      isRecording.value = true;
      print("Recording started: $filePath");
    } catch (e) {
      isRecording.value = false;
      messages.add({
        'message': 'Failed to start recording: $e',
        'isSender': false,
        'isVoice': false,
      });
    }
  }

  /// Stops the recorder, validates file, optionally auto-submits the audio.
  /// Returns true if recording + optional submission succeeded.
  Future<bool> stopRecording({bool autoSubmit = false}) async {
    if (!recorder.isRecording) return false;

    isLoading.value = true;
    try {
      // stopRecorder returns final path in many flutter_sound versions
      final maybePath = await recorder.stopRecorder();
      isRecording.value = false;

      // Prefer returned path, fallback to previously assigned filePath
      final actualPath = maybePath ?? filePath;
      if (actualPath == null) {
        messages.add({
          'message': 'No recorded file was produced.',
          'isSender': false,
          'isVoice': false,
        });
        isLoading.value = false;
        return false;
      }

      final file = File(actualPath);

      // Wait a bit for FS to settle and check size
      int retries = 0;
      while (!await file.exists() || await file.length() < 5000) {
        await Future.delayed(const Duration(milliseconds: 100));
        retries++;
        if (retries > 30) break;
      }

      if (!await file.exists() || await file.length() < 5000) {
        messages.add({
          'message': 'Recording too short. Please speak louder or longer.',
          'isSender': false,
          'isVoice': false,
        });
        filePath = null;
        isLoading.value = false;
        return false;
      }

      // keep path for UI preview / possible manual submit if autoSubmit=false
      filePath = actualPath;

      messages.add({
        'message': '[Voice Message Ready]',
        'isSender': true,
        'isVoice': true,
        'path': file.path,
      });

      if (autoSubmit) {
        final res = await sendVoice(file, lessonId);
        isLoading.value = false;
        return res != null;
      } else {
        isLoading.value = false;
        return true;
      }
    } catch (e) {
      messages.add({
        'message': 'Failed to stop recording: $e',
        'isSender': false,
        'isVoice': false,
      });
      isLoading.value = false;
      return false;
    }
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

  /// Submits a text answer. Returns response body map on success, null on failure.
  Future<Map<String, dynamic>?> submitLesson({required int lessonId, required String answer}) async {
    if (isLoading.value) return null;
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

      http.StreamedResponse streamedResponse = await request.send();

      final responseBodyString = await streamedResponse.stream.bytesToString();

      // if (streamedResponse.statusCode == 200) {
      //   final responseBody = jsonDecode(responseBodyString) as Map<String, dynamic>;
      //
      //   print("Full text response: $responseBodyString");
      //
      //   responseMessage.value = responseBodyString;
      //   aResponse.value.addAll(responseBody);
      //
      //   bool isCorrect = responseBody['submitted_answer']?['is_correct'] ?? false;
      //   String correctText = isCorrect ? "Correct" : "Wrong";
      //
      //   // If answer is wrong, show 2 suggestions from gpt_answers if available
      //   if (!isCorrect && responseBody['gpt_answers'] is List && responseBody['gpt_answers'].length >= 2) {
      //     final suggestions = responseBody['gpt_answers'].take(2).join('\n');
      //     Get.snackbar(
      //       "Your answer is",
      //       "$correctText\nSuggestions:\n$suggestions",
      //       snackPosition: SnackPosition.TOP,
      //       backgroundColor: Colors.red.withOpacity(0.8),
      //       colorText: Colors.white,
      //     );
      //   } else {
      //     Get.snackbar(
      //       "Your answer is",
      //       correctText,
      //       snackPosition: SnackPosition.TOP,
      //       backgroundColor: isCorrect
      //           ? Colors.green.withOpacity(0.8)
      //           : Colors.red.withOpacity(0.8),
      //       colorText: Colors.white,
      //     );
      //   }
      //
      //
      //   bool isCorrectAns = responseBody['correct'];
      //   print("Text answer correctness: $isCorrectAns");
      //
      //   isAnswered.value = isCorrectAns;
      //
      //   return responseBody;
      // }

      if (streamedResponse.statusCode == 200) {
        final responseBody = jsonDecode(responseBodyString) as Map<String, dynamic>;
        
        print("Full text response: $responseBodyString");
        
        responseMessage.value = responseBodyString;
        aResponse.value.addAll(responseBody);
        // show snackbar based on server verdict
        bool isCorrect = responseBody['submitted_answer']?['is_correct'] ?? false;
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

        
        bool isCorrectAns = responseBody['correct'];
        print("Text answer correctness: $isCorrectAns");
        
        isAnswered.value = isCorrectAns;

        return responseBody;
      } else {
        print("Text submission failed: ${streamedResponse.reasonPhrase}");
        Get.snackbar(
          "Submission failed",
          (jsonDecode(responseBodyString)['message'] as String?) ?? "Server returned ${streamedResponse.statusCode}",
        );
        stopRecording();
        isAnswered.value = false;
        return null;
      }
    } catch (e) {
      print("Exception during text submission: $e");
      Get.snackbar("Error", "Failed to submit text answer.");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Sends voice file. Returns response body map on success, null on failure.
  Future<Map<String, dynamic>?> sendVoice(File file, int lessonId) async {


    print("Preparing to send voice file: ${file.path}, lessonId: $lessonId");
    isLoading.value = true;

    String? mp3Path = await convertToMp3(file.path);
    if (mp3Path == null || !await File(mp3Path).exists()) {
      print("MP3 conversion failed");
      Get.snackbar("Error", "Failed to convert audio to mp3.");
      isLoading.value = false;
      return null;
    }

    try {
      print("Sending mp3 file: $mp3Path");
      String? token = await UserInfo.getAccessToken();
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      if (token != null) request.headers['Authorization'] = 'Bearer $token';

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
      
      print("Voice submission response status: ${response.statusCode}");
      print("Voice submission response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBodyString = response.body;
        print("Full voice response: $responseBodyString");

        final responseBody = jsonDecode(responseBodyString) as Map<String, dynamic>;

        bool isCorrect = responseBody['submitted_answer']?['is_correct'] ?? false;
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

        isAnswered.value = responseBody['correct'] ?? false;
        print("Voice answer correctness: ${isAnswered.value}");
        // Clear the filePath after successful send
        try {
          await File(mp3Path).delete();
        } catch (_) {}
        filePath = null;

        return responseBody;
      } else {
        print("Voice submission failed: ${response.reasonPhrase}");
        Get.snackbar("Submission failed", "Server returned ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception during voice submission: $e");
      Get.snackbar("Error", "Failed to submit voice answer.");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Convenience method used by UI when user taps manual submit button.
  /// Returns true if either text or audio submission succeeded.
  Future<bool> submitCurrentAnswer() async {
    if (isLoading.value) return false;

    final hasText = controller.text.trim().isNotEmpty;
    final hasAudio = filePath != null;

    if (!hasText && !hasAudio) {
      Get.snackbar("No input", "Please provide text or audio.");
      return false;
    }

    bool anySuccess = false;

    if (hasText) {
      await submitLesson(lessonId: lessonId, answer: controller.text.trim());
      if (isAnswered.value == true) anySuccess = true;
    }

    if (hasAudio) {
      final file = File(filePath!);
      await sendVoice(file, lessonId);
      if (isAnswered.value == true) anySuccess = true;
    }

    controller.clear();
    filePath = null;
    return anySuccess;
  }
}
