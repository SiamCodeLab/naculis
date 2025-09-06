import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/image_icon.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../home/controller/home_controller.dart';
import '../../quest/controller/quest_answer_controller.dart';
import '../../user_profile/user_profile_controller/profile_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/title_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final answecontroller = Get.put(AnswerController(), permanent: true);
  final UserController userController = Get.find();
  RxInt index = 0.obs;
  final controller = Get.find<LevelsController>();

  void _onSubmit() async {
    final blocks = controller.levelDetails['blocks'] as List? ?? [];
    if (blocks.isEmpty) return;

    final groups = blocks[controller.index]['groups'] as List? ?? [];
    if (groups.isEmpty) return;

    final lessons = groups[controller.qIndex]['lessons'] as List? ?? [];
    if (lessons.isEmpty) return;

    if (userController.user.value.hearts <= 0) {
      Get.snackbar('Please Refill Hearts', 'You do not have enough hearts.');
      return;
    }

    final hasText = answecontroller.controller.text.trim().isNotEmpty;
    final hasVoice = answecontroller.filePath != null;

    if (hasText || hasVoice) {
      answecontroller.lessonId = lessons[index.value]["lesson_id"];
      await answecontroller.submitAnswer();

      if (index.value < lessons.length - 1) {
        index.value++;
        print("Index incremented → reason: ${hasText ? "Text" : "Voice"}");
      } else {
        Get.toNamed(RouteName.quizResult, id: NavIds.home);
      }
    } else {
      print("No input → index not incremented");
      Get.snackbar('Error', 'Please provide text or voice before continuing');
    }

    // Refresh user hearts
    userController.fetchUserData();
  }

  void _onSpeakTap() async {
    if (answecontroller.isRecording.value) {
      await answecontroller.stopRecording();

      // Move to next question
      final blocks = controller.levelDetails['blocks'] as List? ?? [];
      if (blocks.isNotEmpty) {
        final groups = blocks[controller.index]['groups'] as List? ?? [];
        if (groups.isNotEmpty) {
          final lessons = groups[controller.qIndex]['lessons'] as List? ?? [];

          if (index.value < lessons.length - 1) {
            index.value++;
          } else {
            Get.toNamed(RouteName.quizResult, id: NavIds.home);
          }
        }
      }
    } else {
      await answecontroller.startRecording();
      Get.snackbar("Recording Started", "Speak now...");
    }
  }

  void _onTypeTap() {
    answecontroller.filePath = null; // reset audio if typing
    print("Type button tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          TitleCard(title: controller.title, subTitle: ""),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Obx(
                  () => QuestionCard(
                buttonText: answecontroller.isLoading.value
                    ? 'Submitting...'
                    : 'Submit your answer',
                question: controller.levelDetails['blocks'][controller.index]
                ['groups'][controller.qIndex]['lessons'][index.value]
                ['question'],
                controller: answecontroller.controller,
                onSubmit: _onSubmit,
                onTypeTap: _onTypeTap,
                onSpeakTap: _onSpeakTap,
                typeIcon: Image.asset(ImageAndIconConst.typeIcon),
                speakIcon: Obx(
                      () => answecontroller.isRecording.value
                      ? Icon(Icons.mic, color: Colors.red, size: 30)
                      : Image.asset(ImageAndIconConst.speakIcon),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
