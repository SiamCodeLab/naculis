// lesson_quest.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/quest/widgets/quest_button.dart';

import '../../widgets/custom_appbar.dart';
import '../controller/lessonController.dart';

class LessonQuest extends StatefulWidget {
  const LessonQuest({super.key});

  @override
  State<LessonQuest> createState() => _LessonQuestState();
}

class _LessonQuestState extends State<LessonQuest> {
  final controller = Get.put(LessonController(),permanent: true);

  @override
  void dispose() {
    if (Get.isRegistered<LessonController>()) {
      Get.delete<LessonController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestCard(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: "Lesson Quests",
            subtitle:
            "Complete lessons to automatically finish Quests and earn XP!",
            iconAsset: 'assets/images/quiz/trophy.png',
            onTap: () {},
          ),
          Obx(
                () => LessonStatsCard(
              level: controller.level.value,
              totalLesson: controller.totalLessons.value,
              totalXP: controller.totalXp.value,
            ),
          ),
          Obx(
                () => LessonStatsCard(
              earnedXP: controller.earnedXp.value,
              completedLesson: controller.completedLessons.value,
              totalXP: 100,
              totalLesson: controller.totalLessons.value,
              showLevel: false,
            ),
          ),
        ],
      ),
    );
  }
}
