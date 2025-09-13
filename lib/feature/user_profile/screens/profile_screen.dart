import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../../widgets/profile_app_bar.dart';
import '../user_profile_controller/profile_controller.dart';
import '../widgets/friends_card.dart';
import '../widgets/personality_card.dart';
import '../widgets/setting_section.dart';
import '../widgets/stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final UserController userController = Get.put(UserController());


    return Scaffold(
      appBar: ProfileAppBar(title: AppStringEn.profile.tr),
      body: Obx(() {


        final user = userController.user.value;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: user.profilePicture != null && user.profilePicture!.isNotEmpty
                          ? NetworkImage(user.profilePicture!)
                          : const NetworkImage('https://avatar.iran.liara.run/public/17'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Name
              Text(
                "${user.firstName ?? ''} ${user.lastName ?? ''}".trim().isNotEmpty
                    ? "${user.firstName ?? ''} ${user.lastName ?? ''}"
                    : user.username,
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 5),

              // Email
              Text(
                user.email,
                style: Theme.of(context).textTheme.titleSmall,
              ),

              const SizedBox(height: 10),

              // Personality Card
             PersonalityCard(),

              const SizedBox(height: 10),

              // Horizontal scroll cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:[

                    FriendsCard(),
                    StatsCard(),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Settings
             SettingsSection(),
            ],
          ),
        );
      }),
    );
  }
}
