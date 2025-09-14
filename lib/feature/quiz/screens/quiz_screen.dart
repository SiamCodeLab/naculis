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
  final AnswerController answecontroller = Get.put(AnswerController(), permanent: true);
  final UserController userController = Get.find();
  final LevelsController controller = Get.find();

  // local question index for this quiz screen
  RxInt questionIndex = 0.obs;

  void _advanceOrFinish(List lessons) {
    if (questionIndex.value < lessons.length - 1) {
      questionIndex.value++;
    } else {
      Get.toNamed(RouteName.quizResult, id: NavIds.home);
    }
  }

  Future<void> _onSubmit() async {
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

    if (!hasText && !hasVoice) {
      Get.snackbar('Error', 'Please provide text or voice before continuing');
      return;
    }

    // set the lesson id before sending
    answecontroller.lessonId = lessons[questionIndex.value]["lesson_id"];

    // submit and wait for server response
    final success = await answecontroller.submitCurrentAnswer();
    
    print("Submission success: $success");

    if (success) {
      _advanceOrFinish(lessons);
    }

    // refresh hearts/user
    userController.fetchUserData();
  }

  void _onTypeTap() {
    // reset audio preview when user starts typing
    answecontroller.filePath = null;
    print("Type button tapped");
  }

  // Future<void> _onSpeakTap() async {
  //   if (answecontroller.isRecording.value) {
  //     // stop and auto-submit
  //     final blocks = controller.levelDetails['blocks'] as List? ?? [];
  //     final groups = (blocks.isNotEmpty) ? blocks[controller.index]['groups'] as List? ?? [] : [];
  //     final lessons = (groups.isNotEmpty) ? groups[controller.qIndex]['lessons'] as List? ?? [] : [];
  //
  //     // assign lesson id before auto-submit so sendVoice includes it
  //     if (lessons.isNotEmpty) {
  //       answecontroller.lessonId = lessons[questionIndex.value]["lesson_id"];
  //     }
  //
  //     final success = await answecontroller.stopRecording(autoSubmit: true);
  //
  //     if (success) {
  //       // only advance after successful submission
  //       if (lessons.isNotEmpty) {
  //         _advanceOrFinish(lessons);
  //       }
  //       userController.fetchUserData();
  //     } else {
  //       // Failure already surfaced via snackbars from controller
  //     }
  //   } else {
  //     // start recording
  //     await answecontroller.startRecording();
  //     if (answecontroller.isRecording.value) {
  //       Get.snackbar("Recording Started", "Speak now...");
  //     } else {
  //       Get.snackbar("Recording Error", "Could not start recording.");
  //     }
  //   }
  // }


  // Future<void> _onSpeakTap() async {
  //   if (answecontroller.isRecording.value) {
  //     // stop and auto-submit
  //     final blocks = controller.levelDetails['blocks'] as List? ?? [];
  //     final groups = (blocks.isNotEmpty) ? blocks[controller.index]['groups'] as List? ?? [] : [];
  //     final lessons = (groups.isNotEmpty) ? groups[controller.qIndex]['lessons'] as List? ?? [] : [];
  //
  //     // assign lesson id before auto-submit so sendVoice includes it
  //     if (lessons.isNotEmpty) {
  //       answecontroller.lessonId = lessons[questionIndex.value]["lesson_id"];
  //     }
  //
  //     // Hard check: if hearts are 0 before submission, show a message and do not submit
  //     if (userController.user.value.hearts <= 0) {
  //       Get.snackbar('Please Refill Hearts', 'You do not have enough hearts.');
  //       return;
  //     }
  //
  //     await answecontroller.stopRecording(autoSubmit: true);
  //     final success = await answecontroller.submitCurrentAnswer();
  //
  //     if (success) {
  //       // Hard check: if hearts are 0 after submission, show a message and do not advance
  //       if (userController.user.value.hearts <= 0) {
  //         Get.snackbar('No Hearts Left', 'You have run out of hearts. Please refill to continue.');
  //         return;
  //       }
  //       if (lessons.isNotEmpty) {
  //         _advanceOrFinish(lessons);
  //       }
  //       userController.fetchUserData();
  //     } else {
  //
  //     }
  //   } else {
  //     // start recording
  //     await answecontroller.startRecording();
  //     if (answecontroller.isRecording.value) {
  //       Get.snackbar("Recording Started", "Speak now...");
  //     } else {
  //       Get.snackbar("Recording Error", "Could not start recording.");
  //     }
  //   }
  // }

  Future<void> _onSpeakTap() async {
    if (answecontroller.isRecording.value) {
      // Stop and auto-submit
      final blocks = controller.levelDetails['blocks'] as List? ?? [];
      final groups = (blocks.isNotEmpty) ? blocks[controller.index]['groups'] as List? ?? [] : [];
      final lessons = (groups.isNotEmpty) ? groups[controller.qIndex]['lessons'] as List? ?? [] : [];

      if (lessons.isNotEmpty) {
        answecontroller.lessonId = lessons[questionIndex.value]["lesson_id"];
      }

      if (userController.user.value.hearts <= 0) {
        Get.snackbar('Please Refill Hearts', 'You do not have enough hearts.');
        return;
      }

      final success = await answecontroller.stopRecording(autoSubmit: true);
      print("Submission success for voice (correct?): $success");

      if (success) {
        if (userController.user.value.hearts <= 0) {
          Get.snackbar('No Hearts Left', 'You have run out of hearts. Please refill to continue.');
          return;
        }
        _advanceOrFinish(lessons);
        userController.fetchUserData();
      }
    } else {
      await answecontroller.startRecording();
      if (answecontroller.isRecording.value) {
        Get.snackbar("Recording Started", "Speak now...");
      } else {
        Get.snackbar("Recording Error", "Could not start recording.");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final title = controller.title;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                TitleCard(title: title, subTitle: ""),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Obx(
                        () {
                      final blocks = controller.levelDetails['blocks'] as List? ?? [];
                      if (blocks.isEmpty) {
                        return const Center(child: Text("No questions found"));
                      }
                      final groups = blocks[controller.index]['groups'] as List? ?? [];
                      if (groups.isEmpty) {
                        return const Center(child: Text("No groups found"));
                      }
                      final lessons = groups[controller.qIndex]['lessons'] as List? ?? [];
                      if (lessons.isEmpty) {
                        return const Center(child: Text("No lessons found"));
                      }
        
                      final question = lessons[questionIndex.value]['question'] ?? '';
        
                      return QuestionCard(
                        buttonText: answecontroller.isLoading.value ? 'Submitting...' : 'Submit your answer',
                        question: question,
                        controller: answecontroller.controller,
                        onSubmit: _onSubmit,
                        onTypeTap: _onTypeTap,
                        onSpeakTap: _onSpeakTap,
                        typeIcon: Image.asset(ImageAndIconConst.typeIcon),
                        speakIcon: Obx(
                              () => answecontroller.isRecording.value
                              ? const Icon(Icons.mic, color: Colors.red, size: 30)
                              : Image.asset(ImageAndIconConst.speakIcon),
                        ),
                        // // disable the submit button (if your QuestionCard allows)
                        // isSubmitDisabled: answecontroller.isLoading.value,
                      );
                    },
                  ),
                ),
              ],
            ),
        
            // Full-screen loading overlay while submitting / converting etc.
            Obx(() {
              if (answecontroller.isLoading.value) {
                return Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
