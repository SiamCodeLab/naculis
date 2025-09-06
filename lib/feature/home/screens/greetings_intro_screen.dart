import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/image_icon.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/title_card.dart';
import '../controller/home_controller.dart';
import '../widgets/greeting_intro_card.dart';

class GreetingsIntroScreen extends StatefulWidget {
  const GreetingsIntroScreen({super.key});

  @override
  State<GreetingsIntroScreen> createState() => _GreetingsIntroScreenState();
}

class _GreetingsIntroScreenState extends State<GreetingsIntroScreen> {
  final controller = Get.put(LevelsController());

  @override
  void initState() {
    super.initState();
    controller.fetchLevelDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() {
        if (controller.levelDetails.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final blocks = controller.levelDetails['blocks'] as List? ?? [];
        if (blocks.isEmpty) {
          return const Center(child: Text("No Blocks Found"));
        }

        final groups = blocks[controller.index]['groups'] as List? ?? [];

        return SingleChildScrollView(
          child: Column(
            children: [
              TitleCard(
                title: controller.arg ?? 'No Title',
                subTitle: '',
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index] as Map<String, dynamic>;
                  return GreetingIntroCard(
                    title: group['group_name'] ?? 'No Name',
                    subTitle: group['description'] ?? '',
                    leading: ImageAndIconConst.book,
                    trailing: ImageAndIconConst.lock,
                    isCurrent: group['unlocked'] ?? true,
                    onPressed: () {
                      controller.qIndex = index;
                      controller.title = group['group_name'];
                      // ✅ Safe navigation with GetX nested nav
                      if (mounted) {
                        Get.toNamed(RouteName.quiz, id: NavIds.home);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
