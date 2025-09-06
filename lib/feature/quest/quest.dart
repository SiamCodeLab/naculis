// quest.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/quest/widgets/quest_button.dart';

import '../../core/const/app_string.dart';
import '../../core/const/nav_ids.dart';
import '../../routes/route_name.dart';
import '../widgets/custom_appbar.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            QuestButton(
              title: AppStringEn.lessonQuests.tr,
              onTap: () {
                Get.toNamed(RouteName.lessonQuest, id: NavIds.quest);
              },
              iconAsset: 'assets/images/quiz/trophy.png',
            ),
            const SizedBox(height: 20),
            QuestButton(
              title: "Auto-Tracked Quests",
              onTap: () {
                Get.toNamed(RouteName.autoTracked, id: NavIds.quest);
              },
              iconAsset: 'assets/images/quiz/trophy.png',
            ),
          ],
        ),
      ),
    );
  }
}
