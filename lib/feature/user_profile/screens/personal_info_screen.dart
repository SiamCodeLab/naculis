import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/profile_app_bar.dart';
import '../user_profile_controller/profile_controller.dart';
import '../widgets/profile_info_tile.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // Get the UserController instance
    final UserController controller = Get.put(UserController());

    return Scaffold(
      appBar: ProfileAppBar(
        onBackPressed: () => Get.back(id: NavIds.profile),
        title: AppStringEn.profileInfo.tr,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Profile section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 50),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Obx(() {
                    // Observe changes to user data and update the profile image
                    final userData = controller.user.value;
                    return userData.profilePicture != null
                        ? CircleAvatar(
                      radius: 50,
                            backgroundImage: NetworkImage(
                              userData.profilePicture!,
                            ),
                          )
                        : CircleAvatar(
                            radius: 45,
                            // Fallback to a default image if no profile picture is available
                            backgroundImage: AssetImage(
                              'assets/images/default_avatar.png',
                            ),
                          );
                  }),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.mode_edit_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
                onPressed: () {
                  Get.toNamed(RouteName.userProfileEdit, id: NavIds.profile);
                },
              ),
            ],
          ),

          const SizedBox(height: 10),
          Obx(() {
            // Observe changes to user data and update the user name
            final userData = controller.user.value;
            return Text(
              userData.username ?? 'Unknown User',
              // Handling null values for first and last name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            );
          }),
          const SizedBox(height: 5),
          Obx(() {
            // Observe changes to user data and update the email
            final userData = controller.user.value;
            return Text(
              userData.email ?? 'No email available',
              // Fallback to a default if email is null
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            );
          }),
          const SizedBox(height: 30),

          // Profile info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Obx(() {
                  final userData = controller.user.value;
                  return ProfileInfoTile(
                    topLeft: 10,
                    topRight: 10,
                    title: AppStringEn.phone.tr,
                    value: userData.phone ?? 'No phone number available',
                  );
                }),
                Obx(() {
                  final userData = controller.user.value;
                  return ProfileInfoTile(
                    title: AppStringEn.Birthday.tr,
                    value: userData.dob ?? 'No birthday available',
                  );
                }),
                Obx(() {
                  final userData = controller.user.value;
                  return ProfileInfoTile(
                    title: AppStringEn.country.tr,
                    value: userData.country ?? 'No country available',
                    bottomLeft: 10,
                    bottomRight: 10,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
