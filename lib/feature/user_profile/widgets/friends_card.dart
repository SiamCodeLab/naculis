import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';import 'package:share_plus/share_plus.dart';

import '../user_profile_controller/profile_controller.dart';

class FriendsCard extends StatelessWidget {
  const FriendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller=Get.find<UserController>();
    return Container(
      margin: EdgeInsetsGeometry.all(10),
      height: 150,
      width: 180,
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
                'assets/images/user_profile/profile-2user-svgrepo-com 1.png',
              ),
              const SizedBox(width: 10),
              Text(
                'Friends',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Get your squad together!',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 24,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                shareAppInvite( controller.user.value.referralLink);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.share_outlined, color: Colors.white, size: 16),
                  const SizedBox(width: 2),
                  Text(
                    'Invite Friends',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Ean 20 XP + 1 Gem per friend signup!',
            style: TextStyle(fontSize: 8, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

void shareAppInvite( String referral ) async {
  await Share.share(
    'Check out the Naculis Gamming App! Download now: $referral}',
    subject: 'Join me on Naculis Gamming App!',
  );
}
