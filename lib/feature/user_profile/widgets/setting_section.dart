import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/user_profile/widgets/section_tile.dart';
import 'package:naculis/feature/user_profile/widgets/setting_item.dart';
import 'package:naculis/feature/user_profile/widgets/setting_toggle_item.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/nav_ids.dart';
import '../../../core/local_storage/user_info.dart';
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
  String savedLang = 'en'; // default
  bool isDarkMode = false; // default
  bool isLoading = true; // 👈 wait until prefs loaded

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    Locale? locale = await UserInfo.getLocale();
    bool dark = await UserInfo.getIsDarkMode();

    setState(() {
      savedLang = locale?.languageCode ?? 'en';
      isDarkMode = dark;
      isLoading = false;
    });
  }

  Future<void> _changeLanguage(bool isSpanish) async {
    final postLanguageController = Get.put(SlangController(), permanent: true);
    final levelController = Get.put(LevelsController());

    if (isSpanish) {
      Get.updateLocale(const Locale('es', 'ES'));
      await UserInfo.setLocale(const Locale('es', 'ES'));
      await postLanguageController.postlanguage("es");
    } else {
      Get.updateLocale(const Locale('en', 'US'));
      await UserInfo.setLocale(const Locale('en', 'US'));
      await postLanguageController.postlanguage("en");
    }

    // refresh levels
    levelController.fetchLevels();

    setState(() {
      savedLang = isSpanish ? 'es' : 'en';
    });
  }

  Future<void> _changeTheme(bool value) async {
    setState(() {
      isDarkMode = value;
    });
    await UserInfo.setIsDarkMode(value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    final logoutController = Get.put(LogoutController());

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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

          // Dark Mode Toggle (persistent)
          SettingsToggleItem(
            icon: Icons.dark_mode_outlined,
            title: AppStringEn.darkmode.tr,
            initialValue: isDarkMode,
            onChanged: (value) {
              _changeTheme(value);
            },
          ),

          // Language Toggle (persistent)
          SettingsToggleItem(
            icon: Icons.language_outlined,
            title: AppStringEn.changeLanguage.tr,
            initialValue: savedLang == 'es',
            onChanged: (value) {
              _changeLanguage(value);
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
