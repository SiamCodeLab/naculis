import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../../../core/const/image_icon.dart';
import '../user_profile_controller/personality_controller.dart';

class PersonalityCard extends StatelessWidget {
  const PersonalityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalityController());
    return Container(
      margin: EdgeInsetsGeometry.all(10),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ImageAndIconConst.brain),
                Text(
                  AppStringEn.AiPersonalityAnalysis.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black),
                ),
                const SizedBox(width: 25),
                Image.asset(
                  'assets/images/user_profile/material-symbols-light_star-shine-outline-rounded.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Text(
           AppStringEn.getpersonality.tr,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 190,
            height: 32,
            child: ElevatedButton(
              onPressed: () {
                controller.getPersonality();
                // AnalysisDialogBox.show(
                //   title: 'AI Personality analysis',
                //   content:
                //       controller.personality.value['summary'] ?? "Generating.....",
                //   onRefresh: () {
                //     controller.addPersonality();
                //   },
                //   context: context,
                //   controller: controller,
                // );

                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: Color(0xFFFAF8EB),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(ImageAndIconConst.brain),
                              Text(
                                AppStringEn.AiPersonalityAnalysis.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFD22F27),
                                child: IconButton(
                                  icon: const Icon(Icons.close, size: 12),
                                  onPressed: () => Get.back(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 180,
                            child: SingleChildScrollView(
                              child: Obx(
                                    () =>  controller.isLoadingPersonality.value
                                        ? Center(child: CircularProgressIndicator())
                                        : Text(
                                      controller.personality.value['summary']??"Generating.......",
                                      style: const TextStyle(fontSize: 14, color: Colors.black),
                                    )
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 30,
                            width: 175,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.addPersonality();

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    height: 18,
                                    width: 18,
                                    ImageAndIconConst.brain,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                  AppStringEn.refreshAnalysis.tr,
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    ImageAndIconConst.brain,
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                   AppStringEn.generateAnalysiss.tr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
