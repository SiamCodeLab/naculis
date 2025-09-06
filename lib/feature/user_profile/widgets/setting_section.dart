import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/user_profile/widgets/section_tile.dart';
import 'package:naculis/feature/user_profile/widgets/setting_item.dart';
import 'package:naculis/feature/user_profile/widgets/setting_toggle_item.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../home/controller/home_controller.dart';
import '../../profile_set_up/slang_controller/often_slang_controller.dart';
import '../user_profile_controller/logout controller.dart';
class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => SettingsSectionState();
}

class SettingsSectionState extends State<SettingsSection> {

  @override
  Widget build(BuildContext context) {
    // Read saved values (fallbacks included)
    bool isDark = (Theme.of(context).brightness == Brightness.dark);
    String savedLang = 'en';

    final logoutController = Get.put(LogoutController());
    final levelController = Get.put(LevelsController());
    final postLanguageController = Get.put(SlangController(),permanent: true);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔹 Account Section
          SectionTitle(AppStringEn.accountDetails.tr),
          SettingsItem(
            icon: Icons.person_outline,
            title: AppStringEn.personalInfo.tr,
            onTap: () {
              Get.toNamed(RouteName.personalInfo, id: NavIds.profile);
            },
          ),
          SettingsItem(
            icon: Icons.notifications_none,
            title: AppStringEn.notification.tr,
            onTap: () {
              Get.toNamed(RouteName.notification, id: NavIds.profile);
            },
          ),
          SettingsItem(
            icon: Icons.group_outlined,
            title: AppStringEn.referAFriend.tr,
            onTap: () {
              Get.toNamed(RouteName.referFriend, id: NavIds.profile);
            },
          ),

          const SizedBox(height: 10),

          // 🔹 Settings Section
          SectionTitle(AppStringEn.settings.tr),

          // Dark Mode Toggle
          SettingsToggleItem(
            icon: Icons.dark_mode_outlined,
            title: AppStringEn.darkmode.tr,
            initialValue: isDark,
            onChanged: (value) {
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),

          // Language Toggle
          SettingsToggleItem(
            icon: Icons.graphic_eq_outlined,
            title: AppStringEn.changeLanguage.tr,
            initialValue: savedLang == 'es',
            onChanged: (value) async {
              if (value) {
                Get.updateLocale(const Locale('es', 'ES'));
                await postLanguageController.postlanguage("es");
                levelController.fetchLevelDetails();
              } else {
                Get.updateLocale(const Locale('en', 'US'));
                await postLanguageController.postlanguage("en");
                levelController.fetchLevelDetails();

              }
            },
          ),

          const SizedBox(height: 10),

          // 🔹 Earnings Section
          SectionTitle(AppStringEn.earn.tr),
          SettingsItem(
            icon: Icons.account_balance_wallet_outlined,
            title: AppStringEn.myBalance.tr,
            onTap: () {
              Get.toNamed(RouteName.withdraw, id: NavIds.profile);
            },
          ),

          const SizedBox(height: 10),

          // 🔹 Support Section
          SectionTitle(AppStringEn.support.tr),
          SettingsItem(
            icon: Icons.email_outlined,
            title: AppStringEn.contactUs.tr,
            onTap: () {
              Get.toNamed(RouteName.contactUs, id: NavIds.profile);
            },
          ),

          const SizedBox(height: 10),

          // 🔹 Logout
          SettingsItem(
            icon: Icons.power_settings_new_outlined,
            title: AppStringEn.logOut.tr,
            onTap: () {
              logoutController.logout();
            },
          ),
        ],
      ),
    );
  }
}
