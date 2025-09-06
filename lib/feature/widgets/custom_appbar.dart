import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/image_icon.dart';
import '../user_profile/user_profile_controller/profile_controller.dart';
import 'appbar_items.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  // controller কে সঠিকভাবে initialize করলাম
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                        () => AppbarItems(
                      icon: ImageAndIconConst.appbarIcon1,
                      count: controller.user.value.hearts,
                    ),
                  ),
                  Obx(
                        () => AppbarItems(
                      icon: ImageAndIconConst.appbarIcon2,
                      count: controller.user.value.dailyStreak,
                    ),
                  ),
                  Obx(
                        () => AppbarItems(
                      icon: ImageAndIconConst.appbarIcon3,
                      count: controller.user.value.xp,
                    ),
                  ),
                  Obx(
                        () => AppbarItems(
                      icon: ImageAndIconConst.appbarIcon4,
                      count: controller.user.value.gem,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // adjust as needed
}
