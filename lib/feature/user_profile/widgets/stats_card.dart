import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/const/image_icon.dart';
import '../user_profile_controller/profile_controller.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Container(
      margin: EdgeInsetsGeometry.all(10),
      height: 150,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                height: 18,
                width: 18,
                'assets/images/user_profile/tabler_home-stats.png',
              ),
              const SizedBox(width: 10),
              Text(
                'Your Stats',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(
            ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statsIconRow(
                  ImageAndIconConst.diamonds,
                  'Gems',
                  userController.user.value.gem ?? 0,
                  Colors.blue,
                ),
                _statsIconRow(
                  "assets/images/user_profile/Vector-3.png",
                  'Hearts',
                  userController.user.value.hearts ?? 0,
                  Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statsIconRow(
                'assets/images/user_profile/Vector.png',
                'Level',
                userController.user.value.level ?? 0,
                Colors.yellow,
              ),
              const SizedBox(width: 7),
              _statsIconRow(
                "assets/images/user_profile/Vector-1.png",
                'Day Streak',
                userController.user.value.dailyStreak ?? 0,
                Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 5),
              _statsIconRow(
                "assets/images/user_profile/Vector-2.png",
                'XP',
                userController.user.value.xp ?? 0,
                Colors.purpleAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _statsIconRow(String icon, String title, int count, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, color: color, height: 16, width: 16),
      const SizedBox(width: 5),
      Text(
          '$title $count',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

    ],
  );
}
