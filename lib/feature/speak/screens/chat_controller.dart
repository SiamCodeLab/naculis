
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
  var isLoading = false.obs; // 👈 loading state for bot response
  String? filePath;

  final String apiUrl = ApiEndpoints.chatbot;

  @override
  void onInit() {
    super.onInit();
    _initRecorderAndPlayer();
  }

  /// Initialize recorder & player safely
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

  /// Request microphone permission
  Future<bool> requestPermissions() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar("Permission Denied", "Microphone access is required.",
          snackPosition: SnackPosition.BOTTOM);
    }
    return status.isGranted;
  }

  /// Start recording
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

  /// Stop recording and send
  Future<void> stopRecording() async {
    if (!recorder.isRecording) return;

    try {
      await recorder.stopRecorder();
      isRecording.value = false;

      final file = File(filePath!);
      if (!await file.exists() || await file.length() < 1000) {
        Get.snackbar("Too Short", "Please speak louder or longer.",
            snackPosition: SnackPosition.TOP);
        return;
      }

      // Add local voice bubble
      messages.add({
        'message': '[Voice]',
        'isSender': true,
        'isVoice': true,
        'path': file.path,
      });

      // Show typing bubble
      isLoading.value = true;

      // Send to server
      await sendVoice(file);

      filePath = null;
    } catch (e) {
      Get.snackbar("Stop Recording Error", "$e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Convert AAC to MP3
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
    } catch (e) {
      return null;
    }
  }

  /// Send to backend
  Future<void> sendVoice(File file) async {
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
      if (response.statusCode == 200) {
        messages.add({
          'message': body['response'] ?? "Response received",
          'isSender': false,
          'isVoice': false,
        });
      } else {
        Get.snackbar("Server Error", "Code ${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Send Error", "$e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Play voice
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
