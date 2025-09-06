import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/title_card.dart';
import '../controller/home_controller.dart';
import '../widgets/progress_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final controller = Get.put(LevelsController());

  @override
  void initState() {
    super.initState();
    controller.fetchLevelDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(),
      body: Obx(() {
        if (controller.levelDetails.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final name = controller.levelDetails['name'] ?? 'No Name';
        final description = controller.levelDetails['description'] ?? '';
        final blocks = controller.levelDetails['blocks'] ?? [];
        final progress = controller.levelDetails['progress'] ?? {};

        return SingleChildScrollView(
          child: Column(
            children: [
              TitleCard(
                title: name,
                details: description,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: blocks.length,
                itemBuilder: (context, index) {
                  final block = blocks[index];
                  final total = (progress['total'] ?? 1);
                  final completed = (progress['completed_count'] ?? 0);

                  return ProgressCard(
                    onPress: () {
                      controller.arg = block['block_name'];
                      controller.index = index;
                      if (mounted) {
                        Get.toNamed(
                          RouteName.greetingsAndIntro,
                          id: NavIds.home,
                        );
                      }
                    },
                    title: block['block_name'] ?? 'No Block Name',
                    lessons: total,
                    completed: completed,
                    progress: total > 0 ? completed / total : 0.0,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
