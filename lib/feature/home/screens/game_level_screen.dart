import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/image_icon.dart';
import '../../../core/const/level.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/custom_appbar.dart';
import '../controller/home_controller.dart';
import '../widgets/custom_object.dart';
import '../widgets/custom_positoned.dart';

class GameLevelScreen extends StatelessWidget {
  const GameLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: AspectRatio(aspectRatio: 9 / 16, child: RoadScrollView()),
      ),
    );
  }
}

class RoadScrollView extends StatelessWidget {
  const RoadScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LevelsController());

    return Obx(() {
      if (controller.levelList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final areaHeight = constraints.maxHeight;
          final areaWidth = constraints.maxWidth;
          const double roadWidthRatio = 0.38;
          final double roadWidth = areaWidth * roadWidthRatio;
          final double roadLeft = (areaWidth - roadWidth) / 2;

          // Calculate how many screen sections we need (3 levels per screen)
          final int screenCount = (controller.levelList.length / 3).ceil();

          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              overscroll: false,
              scrollbars: false,
            ),
            child: ListView.builder(
              itemCount: screenCount,
              reverse: false,
              itemBuilder: (context, screenIndex) {
                // Calculate which levels to show on this screen
                final int startLevelIndex = screenIndex * 3;

                return SizedBox(
                  height: areaHeight,
                  width: areaWidth,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          ImageAndIconConst.road,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Building left
                      CustomPosition(

                        left: roadLeft - roadWidth * 0.45,
                        bottom: areaHeight * 0.03,
                        child: Image.asset(
                          width: areaWidth > 600
                              ? roadWidth * 0.9
                              : roadWidth * 0.7,
                          ImageAndIconConst.building2,
                        ),
                      ),

                      // Building right
                      CustomPosition(
                        left: roadLeft + roadWidth * 0.65,
                        bottom: areaHeight * 0.5,
                        child: Image.asset(
                          width: areaWidth > 600
                              ? roadWidth * 0.9
                              : roadWidth * 0.7,
                          ImageAndIconConst.building2,
                        ),
                      ),

                      // First Position
                      if (startLevelIndex < controller.levelList.length)
                        CustomPosition(
                          onPress: () {
                            controller.levelid=controller.levelList[startLevelIndex].levelId;
                            Get.toNamed(
                              RouteName.gameProgress,
                              id: NavIds.home,

                            );
                            controller.fetchLevelDetails();
                          },
                          top: areaHeight * 0.021,
                          left: roadLeft + roadWidth + roadWidth * 0.02,
                          child: CustomObject(
                            image: controller.levelList[startLevelIndex].unlocked
                                ? ImageAndIconConst.streetSignColor
                                : ImageAndIconConst.streetSign,
                            title: controller.levelList[startLevelIndex].name,
                          ),
                        ),

                      // Second Position
                      if (startLevelIndex + 1 < controller.levelList.length)
                        CustomPosition(
                          onPress: controller.levelList[startLevelIndex + 1].unlocked
                              ?() {
                                controller.levelid=controller.levelList[startLevelIndex+1].levelId;
                                Get.toNamed(RouteName.gameProgress, id: NavIds.home);
                                controller.fetchLevelDetails();
                              }
                              : null,
                          top: areaHeight * 0.31,
                          left: roadLeft - roadWidth * 0.7,
                          child: CustomObject(
                            image: controller.levelList[startLevelIndex + 1].unlocked
                                ? ImageAndIconConst.speaker
                                : ImageAndIconConst.voltColerLess,
                            title:
                                controller.levelList[startLevelIndex + 1].name,
                          ),
                        ),

                      // Third Position
                      if (startLevelIndex + 2 < controller.levelList.length)
                        CustomPosition(
                          onPress: controller.levelList[startLevelIndex + 2].unlocked
                              ?() {
                                  controller.levelid=controller.levelList[startLevelIndex+2].levelId;
                                  Get.toNamed(RouteName.gameProgress, id: NavIds.home);
                                  controller.fetchLevelDetails();
                              }
                              : null,
                          bottom: areaHeight * 0.15,
                          right: roadLeft - roadWidth * 0.45,
                          child: CustomObject(
                            image: controller.levelList[startLevelIndex + 2].unlocked
                                ? ImageAndIconConst.streetSignColor
                                : ImageAndIconConst.streetSign,
                            title:
                                controller.levelList[startLevelIndex + 2].name,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
