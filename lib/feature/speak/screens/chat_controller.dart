import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';

class ChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;

  late FlutterSoundRecorder recorder;
  late FlutterSoundPlayer player;

  var isRecording = false.obs;
  var isLoading = false.obs;

  String? filePath;
  int? conversationId; // 👈 track current conversation

  final String apiUrl = ApiEndpoints.chatbot;

  @override
  void onInit() {
    super.onInit();
    _initRecorderAndPlayer();
  }

  // -------------------- Recorder & Permissions --------------------
  Future<void> _initRecorderAndPlayer() async {
    recorder = FlutterSoundRecorder();
    player = FlutterSoundPlayer();
    try {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
      await player.openPlayer();
    } catch (e) {
      Get.snackbar("Audio Error", "Could not init recorder: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar("Permission Denied", "Microphone access is required.",
          snackPosition: SnackPosition.BOTTOM);
    }
    return status.isGranted;
  }

  // -------------------- Recording --------------------
  Future<void> startRecording() async {
    if (!await requestPermissions()) return;
    if (recorder.isRecording) return;

    final dir = await getTemporaryDirectory();
    filePath = '${dir.path}/voice_message.aac';

    try {
      await recorder.startRecorder(toFile: filePath);
      isRecording.value = true;
    } catch (e) {
      Get.snackbar("Recording Error", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> stopRecording() async {
    if (!recorder.isRecording) return;

    try {
      await recorder.stopRecorder();
      isRecording.value = false;

      final file = File(filePath!);
      if (!await file.exists() || await file.length() < 1000) {
        Get.snackbar("Too Short", "Please speak louder or longer.",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      messages.add({
        'message': '[Voice]',
        'isSender': true,
        'isVoice': true,
        'path': file.path,
      });

      isLoading.value = true;
      await sendVoice(file);

      filePath = null;
    } catch (e) {
      Get.snackbar("Stop Recording Error", "$e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // -------------------- Voice Conversion --------------------
  Future<String?> convertToMp3(String aacPath) async {
    final mp3Path = aacPath.replaceAll('.aac', '.mp3');
    try {
      final session = await FFmpegKit.execute(
          '-y -i "$aacPath" -vn -ar 44100 -ac 2 -b:a 128k "$mp3Path"');
      final returnCode = await session.getReturnCode();
      if (returnCode != null && returnCode.isValueSuccess()) {
        return mp3Path;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // -------------------- API Calls --------------------
  Future<void> sendVoice(File file) async {
    isLoading.value = true;
    try {
      String? mp3Path = await convertToMp3(file.path);

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      String? token = await UserInfo.getAccessToken();
      if (token != null) request.headers['Authorization'] = 'Bearer $token';

      if (mp3Path != null && await File(mp3Path).exists()) {
        request.files.add(await http.MultipartFile.fromPath(
          'audio',
          mp3Path,
          contentType: MediaType('audio', 'mpeg'),
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'audio',
          file.path,
          contentType: MediaType('audio', 'aac'),
        ));
      }

      request.fields['type'] = 'voice';
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        isLoading.value = false;
        // ✅ Save conversation_id
        conversationId = body['conversation_id'];

        messages.add({
          'message': body['response'] ?? "Response received",
          'isSender': false,
          'isVoice': false,
        });
      } else {
        isLoading.value = false;
        Get.snackbar("Server Error", "Code ${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Send Error", "$e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Load conversation history
  // Future<void> loadConversationHistory(int convId) async {
  //   try {
  //     String? token = await UserInfo.getAccessToken();
  //     final url = "${ApiEndpoints.baseUrl}/core/conversations/";
  //
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {"Authorization": "Bearer $token"},
  //     );
  //
  //     print('History Response: ${response.body} and Status: ${response.statusCode}');
  //
  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       messages.clear();
  //
  //       for (var msg in body['messages']) {
  //         messages.add({
  //           'message': msg['content'],
  //           'isSender': msg['role'] == 'user',
  //           'isVoice': false, // history is text only
  //         });
  //       }
  //     } else {
  //       Get.snackbar("History Error", "Code ${response.statusCode}",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     Get.snackbar("History Error", "$e", snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  Future<void> loadConversationHistory(int convId) async {
    try {
      String? token = await UserInfo.getAccessToken();
      final url = "${ApiEndpoints.baseUrl}/core/conversations-history/";

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      print('History Response: ${response.body} and Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        messages.clear();

        final history = body['messages'] as List<dynamic>? ?? [];

        for (var msg in history) {
          messages.add({
            'message': msg['content'] ?? '',
            'isSender': msg['role'] == 'user',
            'isVoice': false, // history is text only
            'created_at': msg['created_at'], // optional timestamp
          });
        }
      } else {
        Get.snackbar("History Error", "Code ${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("History Error", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }



  // -------------------- Playback --------------------
  Future<void> playVoice(String path) async {
    if (!await File(path).exists()) return;
    try {
      await player.startPlayer(
        fromURI: path,
        whenFinished: () => player.stopPlayer(),
      );
    } catch (e) {
      Get.snackbar("Playback Error", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.onClose();
  }
}
