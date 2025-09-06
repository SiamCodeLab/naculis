import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/image_icon.dart';
import '../user_profile_controller/personality_controller.dart';
class AnalysisDialogBox {
  static void show({
    required String title,
    required String content,
    required VoidCallback onRefresh,
    required BuildContext context,

    required PersonalityController controller
  }) {
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
                    title,
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
                    () =>  Text(
                    controller.personality.value['summary']??"Generating.......",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 30,
                width: 175,
                child: ElevatedButton(
                  onPressed: onRefresh,
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
                      const Text(
                        'Refresh Analysis',
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
  }
}
