import 'package:flutter/material.dart';
import 'package:get/get.dart';import '../../../core/const/image_icon.dart';
import '../../quest/controller/auto_tracked_ans_controller.dart';
import '../../user_profile/user_profile_controller/profile_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/title_card.dart';

class AutoTrackedQuestQuestion extends StatefulWidget {
  const AutoTrackedQuestQuestion({super.key});

  @override
  State<AutoTrackedQuestQuestion> createState() => _AutoTrackedQuestQuestionState();
}

class _AutoTrackedQuestQuestionState extends State<AutoTrackedQuestQuestion> {
  final TextEditingController _controller = TextEditingController();
  final controller = Get.find<TaskController>();
  final userController = Get.find<UserController>();
  RxInt index = 0.obs;

  void _onSubmit() async {
    final groupList = controller.taskList;
    if (groupList.isEmpty) return;

    final group = groupList[0];
    final questions = group['questions'] as List? ?? [];
    if (questions.isEmpty) return;

    if (userController.user.value.hearts > 0) {
      controller.answerController.text = _controller.text.trim();

      // Submit text answer
      await controller.submitTextAnswer();

      // Move to next question
      if (index.value < questions.length - 1) {
        index.value++;
        _controller.clear();
      } else {
        // All questions done, navigate to result
        Get.toNamed('/quizResult');
      }
    } else {
      Get.snackbar(
        'No Hearts Left',
        'You need at least 1 heart to submit.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void _onSpeakTap() async {
    if (controller.isRecording.value) {
      await controller.stopRecording();

      // Move to next question automatically after sending
      final groupList = controller.taskList;
      if (groupList.isNotEmpty) {
        final group = groupList[0];
        final questions = group['questions'] as List? ?? [];

        if (index.value < questions.length - 1) {
          index.value++;
        } else {
          Get.toNamed('/quizResult');
        }
      }
      _controller.clear();
    } else {
      await controller.startRecording();
      Get.snackbar("Recording Started", "Speak now...");
    }
  }

  void _onTypeTap() {
    print("Type button tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          const TitleCard(title: "Auto Tracked Question", subTitle: ""),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Obx(() {
              final groupList = controller.taskList;
              if (groupList.isEmpty) return const Center(child: CircularProgressIndicator());

              final group = groupList[0];
              final questions = group['questions'] as List? ?? [];
              if (questions.isEmpty) return const Text("No questions found");

              final question = questions[index.value]['question'] ?? "No question";

              return QuestionCard(
                buttonText: controller.isLoading.value ? 'Submitting...' : 'Submit your answer',
                question: question,
                controller: _controller,
                onSubmit: _onSubmit,
                onTypeTap: _onTypeTap,
                onSpeakTap: _onSpeakTap,
                typeIcon: Image.asset(ImageAndIconConst.typeIcon),
                speakIcon: Obx(() => controller.isRecording.value
                    ? const Icon(Icons.mic, color: Colors.red, size: 30)
                    : Image.asset(ImageAndIconConst.speakIcon)),
              );
            }),
          ),
        ],
      ),
    );
  }
}
