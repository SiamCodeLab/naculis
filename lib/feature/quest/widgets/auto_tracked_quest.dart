// auto_tracked_quest.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/quest/widgets/quest_button.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/custom_appbar.dart';
import '../controller/auto_tracked_ans_controller.dart';

class Auto_Tracked extends StatefulWidget {
  Auto_Tracked({super.key});

  @override
  State<Auto_Tracked> createState() => _Auto_TrackedState();
}

class _Auto_TrackedState extends State<Auto_Tracked> {
  final TaskController controller = Get.put(TaskController(),permanent: true);

  double parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  void dispose() {
    if (Get.isRegistered<TaskController>()) {
      Get.delete<TaskController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          QuestCard(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: "Auto Tracked Quests",
            subtitle:
            "Complete lessons to automatically finish Quests and earn XP!",
            iconAsset: 'assets/images/quiz/trophy.png',
            onTap: () {},
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.taskList.isEmpty) {
                return const Center(child: Text("No tasks found"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  final task = controller.taskList[index];
                  final currentProgress = parseDouble(
                    task['completion_percent'],
                  );
                  final totalProgress = task['questions_total'] != null
                      ? parseDouble(task['questions_total'])
                      : 1.0;

                  double progress = currentProgress / 100;

                  return GestureDetector(
                    onTap: () {
                      controller.index.value = index;
                      Get.toNamed(RouteName.questQuestion, id: NavIds.quest);
                    },
                    child: QuestProgressCard(
                      category: "Basic",
                      title: task['group_name'] ?? '',
                      subtitle: "Complete ${task['questions_total']} lessons",
                      currentProgress: currentProgress,
                      totalProgress: totalProgress,
                      rewardXP: task['xp_total'] ?? 0,
                      progressbar: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        minHeight: 15,
                        borderRadius: BorderRadius.circular(10),
                        value: progress,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
