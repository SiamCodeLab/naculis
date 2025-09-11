import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/const/app_string.dart';
import '../../core/const/nav_ids.dart';
import '../user_profile/user_profile_controller/profile_controller.dart';
import '../widgets/profile_app_bar.dart';

class ReferFriend extends StatelessWidget {
  const ReferFriend({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: ProfileAppBar(
        onBackPressed: () => Get.back(id: NavIds.profile),
        title: AppStringEn.referAFriend.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            SelectableText(
              "Referral Code:   ${controller.user.value.referralCode}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.tertiaryFixed,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Illustration Image
            Image.asset(
              'assets/images/Refer.png', // Replace with your actual image path
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),

            // Offer Text
            Text(
              AppStringEn.ReferFriendAndGetOff.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            ),
            const Spacer(),

            // Refer Button
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Share.share(controller.user.value.referralLink);
                  },
                  child: Text(
                    AppStringEn.Refer.tr,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
